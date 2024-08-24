export function objToQueryString(obj) {
    let url = '';
    for (const key in obj) {
        if (obj[key] === undefined || obj[key] === '') continue;
        if (obj[key] instanceof Array)
            for (const val of obj[key]) {
                url = url.concat(`${key}=${val}&`)
            }
        else {
            url = url.concat(`${key}=${obj[key]}&`)
        }
    }
    return url.substring(0, url.length - 1);
}

export function idsToPathVariable(ids) {
    if (ids instanceof Array) {
        return ids.join(',')
    } else {
        return ids
    }
}


