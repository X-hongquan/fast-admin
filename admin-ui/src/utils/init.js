export function preHandleMenu(menus) {
    const map = new Map();
    let arr = []
    for (const menu of menus) {
        map.set(menu.id, menu);
        if (menu.parentId === '0') {
            arr.push(menu)
        } else {
            const parent = map.get(menu.parentId);
            if (!parent.children) {
                parent.children = [];
            }
            parent.children.push(menu);
        }
    }
    return {map, arr}

}
