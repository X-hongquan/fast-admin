import{B as e}from"./index-C5uf1WvN.js";function o(i,n="操作",t,a){i.code===200?(t instanceof Function&&t(),e({type:"success",message:`${n}成功`,duration:1e3})):(a instanceof Function&&a(),e({type:"error",message:`${i.msg}`,duration:1500}))}function c(i,n,t){o(i,"添加",n,t)}function s(i,n,t){o(i,"修改",n,t)}function u(i,n,t){o(i,"删除",n,t)}export{c as a,u as d,s as u};
