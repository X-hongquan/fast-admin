function t(n,r,e){r.length<5?e(new Error("用户名长度不能小于4")):e()}function o(n,r,e){r.length<6||r.length>20?e(new Error("密码长度不能小于6或大于20")):e()}function i(n,r,e){/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/.test(r)?e():e(new Error("邮箱格式不正确"))}function f(n,r,e){r.length===0&&e(new Error("选项不能为空")),e()}export{t as a,o as b,i as c,f as d};
