export function preHandleMenu(menus) {
    const map = new Map();
    const second = new Map();
    let arr = []
    for (const menu of menus) {
        if (menu.level === 1) {
            map.set(menu.id, menu);
            arr.push(menu)
        }
        if (menu.level === 2) {
            const parent = map.get(menu.parentId);
            if (parent) {
                if (!parent.children) {
                    parent.children = [];
                }
                second.set(menu.id, menu);
                parent.children.push(menu);
            }
        }
        if (menu.level === 3) {
            const parent = second.get(menu.parentId);
            if (parent) {
                if (!parent.children) {
                    parent.children = [];
                }
                parent.children.push(menu);
            }
        }
    }
    return {map, second, arr}

}
