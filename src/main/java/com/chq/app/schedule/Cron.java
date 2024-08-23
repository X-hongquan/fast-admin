package com.chq.app.schedule;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import lombok.extern.slf4j.Slf4j;

import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.HashSet;

import java.util.Set;

@Slf4j
@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
public class Cron {
    private Set<Integer> seconds;
    private Set<Integer> minutes;
    private Set<Integer> hours;
    private Set<Integer> days;
    private Set<Integer> months;
    private Set<Integer> weeks;

    public Cron(String cron) {
        String[] split = cron.split(" ");
        if (!cron.contains("?"))
            throw new RuntimeException("cron表达式错误");
        if ("?".equals(split[3]) && "?".equals(split[5]))
            throw new RuntimeException("cron表达式错误");
        this.seconds = new HashSet<>();
        this.minutes = new HashSet<>();
        this.hours = new HashSet<>();
        this.days = new HashSet<>();
        this.months = new HashSet<>();
        this.weeks = new HashSet<>();
        fillSeconds(split[0]);
        fillMinutes(split[1]);
        fillHours(split[2]);
        fillDays(split[3]);
        fillMonths(split[4]);
        fillWeek(split[5]);
    }


    private static Set<String> defaultSet = Set.of(
            "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
            "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
            "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
            "31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
            "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
            "51", "52", "53", "54", "55", "56", "57", "58", "59"
    );



    private void fillSeconds(String s) {
        if ("*".equals(s)) {
            for (int i = 0; i < 59; i++) {
                seconds.add(i);
            }
        } else if (s.contains("/")) {
            String[] split = s.split("/");
            int start = Integer.parseInt(split[0]);
            int rate = Integer.parseInt(split[1]);
            for (int i = start; i <= 59; i += rate) {
                seconds.add(i);
            }
        } else {
            addOther(s, seconds);
        }

    }

    private void fillMinutes(String s) {
        if ("*".equals(s)) {
            for (int i = 0; i < 59; i++) {
                minutes.add(i);
            }
        } else if (s.contains("/")) {
            String[] split = s.split("/");
            int start = Integer.parseInt(split[0]);
            int rate = Integer.parseInt(split[1]);
            for (int i = start; i <= 59; i += rate) {
                minutes.add(i);
            }
        } else {
            addOther(s, minutes);
        }
    }

    private void fillHours(String s) {
        if ("*".equals(s)) {
            for (int i = 0; i < 23; i++) {
                hours.add(i);
            }
        } else if (s.contains("/")) {
            String[] split = s.split("/");
            int start = Integer.parseInt(split[0]);
            int rate = Integer.parseInt(split[1]);
            for (int i = start; i <= 23; i += rate) {
                hours.add(i);
            }
        } else {
            addOther(s, hours);
        }
    }

    private void fillDays(String s) {
        YearMonth now = YearMonth.now();
        int end = now.lengthOfMonth();
        if ("*".equals(s)) {
            for (int i = 1; i <= end; i++) {
                days.add(i);
            }
        } else if ("1L".equals(s)) {
            days.add(end);
        } else if (s.contains("/")) {
            String[] split = s.split("/");
            int start = Integer.parseInt(split[0]);
            int rate = Integer.parseInt(split[1]);
            for (int i = start; i <= end; i += rate) {
                days.add(i);
            }
        } else {
            addOther(s, days);
        }
    }

    private void fillMonths(String s) {
        if ("*".equals(s)) {
            for (int i = 1; i <= 12; i++) {
                months.add(i);
            }
        } else if (s.contains("/")) {
            String[] split = s.split("/");
            int start = Integer.parseInt(split[0]);
            int rate = Integer.parseInt(split[1]);
            for (int i = start; i <= 12; i += rate) {
                months.add(i);
            }
        } else {
            addOther(s, months);
        }
    }

    private void fillWeek(String s) {
        if ("*".equals(s)) {
            for (int i = 1; i <= 7; i++) {
                weeks.add(i);
            }
        } else {
            addOther(s, weeks);
        }
    }


    private void addOther(String s, Set<Integer> smh) {
        if (s.contains("-")) {
            String[] split = s.split("-");
            int start = Integer.parseInt(split[0]);
            int end = Integer.parseInt(split[1]);
            for (int i = start; i <= end; i++) {
                smh.add(i);
            }
        } else if (s.contains(",")) {
            String[] split = s.split(",");
            for (String s1 : split) {
                smh.add(Integer.parseInt(s1));
            }
        } else if (smh != weeks && smh != days) {
            if (!defaultSet.contains(s))
                throw new RuntimeException("cron表达式错误");
            smh.add(Integer.parseInt(s));
        }
    }


    public boolean isMatch() {
        LocalDateTime now = LocalDateTime.now();
        int second = now.getSecond();
        int minute = now.getMinute();
        int hour = now.getHour();
        int day = now.getDayOfMonth();
        int month = now.getMonthValue();
        DayOfWeek dayOfWeek = now.getDayOfWeek();
        int week = dayOfWeek.getValue();
        if (!months.contains(month))
            return false;
        if (weeks.isEmpty()) {
            if (!days.contains(day))
                return false;
        } else {
            if (!weeks.contains(week))
                return false;
        }
        if (!hours.contains(hour)) {
            return false;
        }
        if (!minutes.contains(minute)) {
            return false;
        }
        if (!seconds.contains(second)) {
            return false;
        }
        return true;
    }


}
