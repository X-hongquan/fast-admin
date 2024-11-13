package com.chq.app.common.schedule;


import com.chq.app.common.exception.ServiceException;
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


    private Set<String> defaultSet = Set.of(
            "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
            "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
            "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
            "31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
            "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
            "51", "52", "53", "54", "55", "56", "57", "58", "59"

    );


    public Cron(String cron) {
        String[] split = checkCron(cron);
        this.seconds = new HashSet<>();
        this.minutes = new HashSet<>();
        this.hours = new HashSet<>();
        this.days = new HashSet<>();
        this.months = new HashSet<>();
        this.weeks = new HashSet<>();
        fillSeconds(split[0], 0, 59);
        fillMinutes(split[1], 0, 59);
        fillHours(split[2], 0, 24);
        fillDays(split[3], 1, YearMonth.now().lengthOfMonth());
        fillMonths(split[4], 1, 12);
        fillWeek(split[5], 1, 7);
    }

    private int countStr(String corn, char c) {
        int count = 0;
        for (int i = 0; i < corn.length(); i++) {
            if (c == corn.charAt(i)) count++;
        }
        return count;
    }

    private String[] checkCron(String cron) {
        int count = countStr(cron, '?');
        if (count != 1)
            throw new ServiceException("cron表达式错误");
        String[] split = cron.split(" ");
        if (split.length != 6 || ("?".equals(split[3]) && "?".equals(split[5])))
            throw new ServiceException("cron表达式错误");
        return split;
    }


    private void fill(String s, Set<Integer> smh, int finalStart, int finalEnd) {
        if ("*".equals(s)) {
            for (int i = finalStart; i <= finalEnd; i++) {
                smh.add(i);
            }
        } else if (s.contains("/")) {
            String[] split = s.split("/");
            int target = Integer.parseInt(split[0]);
            int rate = Integer.parseInt(split[1]);
            checkRange(finalStart, finalEnd, target);
            for (int i = target; i <= finalEnd; i += rate) {
                smh.add(i);
            }
        } else if (s.contains(",")) {
            String[] split = s.split(",");
            for (String s1 : split) {
                int i = Integer.parseInt(s1);
                checkRange(finalStart, finalEnd, i);
                smh.add(i);
            }
        } else if (s.contains("-")) {
            String[] split = s.split("-");
            int start = Integer.parseInt(split[0]);
            int end = Integer.parseInt(split[1]);
            checkRange(finalStart, finalEnd, start);
            checkRange(finalStart, finalEnd, end);
            for (int i = start; i <= end; i++) {
                smh.add(i);
            }
        } else if ("?".equals(s)) {
            if (smh != weeks && smh != days)
                throw new ServiceException("cron表达式错误");
        } else if ("1L".equals(s)) {
            if (smh != days)
                throw new ServiceException("cron表达式错误");
            days.clear();
            smh.add(finalEnd);
        } else if (defaultSet.contains(s)) {
            int i = Integer.parseInt(s);
            checkRange(finalStart, finalEnd, i);
            smh.add(i);
        } else {
            throw new ServiceException("cron表达式错误");
        }
    }

    private void checkRange(int finalStart, int finalEnd, int target) {
        if (target < finalStart || target > finalEnd)
            throw new ServiceException("cron表达式错误");
    }


    private void fillSeconds(String s, int finalStart, int finalEnd) {
        fill(s, seconds, finalStart, finalEnd);
    }


    private void fillMinutes(String s, int finalStart, int finalEnd) {
        fill(s, minutes, finalStart, finalEnd);
    }


    private void fillHours(String s, int finalStart, int finalEnd) {
        fill(s, hours, finalStart, finalEnd);
    }

    public void fillDays(String s, int finalStart, int finalEnd) {
        fill(s, days, finalStart, finalEnd);
    }

    private void fillMonths(String s, int finalStart, int finalEnd) {
        fill(s, months, finalStart, finalEnd);
    }

    private void fillWeek(String s, int finalStart, int finalEnd) {
        fill(s, weeks, finalStart, finalEnd);
    }


    public boolean isMatch(LocalDateTime now) {
        int second = now.getSecond();
        int minute = now.getMinute();
        int hour = now.getHour();
        int day = now.getDayOfMonth();
        int month = now.getMonthValue();
        DayOfWeek dayOfWeek = now.getDayOfWeek();
        int week = dayOfWeek.getValue();
        if (months.contains(month)) {
            if (weeks.isEmpty()) {
                if (!days.contains(day))
                    return false;
            } else {
                if (!weeks.contains(week))
                    return false;
            }
            if (hours.contains(hour) && minutes.contains(minute) && seconds.contains(second))
                return true;
        }
        return false;
    }


}
