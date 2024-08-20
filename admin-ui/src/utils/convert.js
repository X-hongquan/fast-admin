export function objToQueryString(obj) {
    let url = '';
    for (const key in obj) {
        if (obj[key] === undefined || obj[key] === '') continue;
        url = url.concat(`${key}=${obj[key]}&`)
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


