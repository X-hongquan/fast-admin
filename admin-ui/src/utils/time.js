export function getTimes(){
    let hours = new Date().getHours();
    if (hours >= 6 && hours < 12) {
        return '早上好'
    } else if (hours >= 12 && hours < 14) {
        return '中午好'
    } else if (hours >= 14 && hours < 18) {
        return '下午好'
    } else if (hours >= 18 && hours < 24) {
        return '晚上好'
    } else {
        return '凌晨好,时间不早了早点去休息吧'
    }
}
