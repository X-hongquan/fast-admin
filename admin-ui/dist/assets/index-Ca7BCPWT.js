import{_ as E,h as _,i as q,H as F,r as s,o as p,c as f,b as g,a as e,w as n,F as z,k as S,C as N,e as r,t as M,B as T,a1 as j,a2 as H}from"./index-C5uf1WvN.js";import{g as G}from"./index-Cpqr1tGl.js";import{h as J}from"./confirm-CxKUQBJO.js";import{d as K}from"./notification-DhcrVVnz.js";const O={class:"content-box"},Q={class:"search-box"},W={class:"operation-box"},X={class:"pagination-box"},Y={__name:"index",setup(Z){const b=_([]),o=q({pageNum:1,pageSize:10,roleId:void 0,status:void 0}),v=_(0),y=_([]),C=_([]);function U(t){C.value=t}function V(){let t=C.value.map(l=>l.id);h(t)}function h(t){t instanceof Array?J(async()=>{const l=await H(t);K(l,()=>{u()})}):T.error("请选择要删除的数据")}async function $(t){let l=[t.id];h(l)}function B(){o.roleId=void 0,o.status=void 0,u()}async function u(){const t=await j(o);t.code===200&&(b.value=t.data,v.value=Number(t.total))}async function I(){const t=await G();t.code===200&&(y.value=t.data)}function w(t){o.pageNum=1,u()}function L(t){u()}return F(()=>{u(),I()}),(t,l)=>{const m=s("el-option"),k=s("el-select"),x=s("el-form-item"),D=s("el-form"),d=s("el-button"),i=s("el-table-column"),P=s("el-tag"),A=s("el-table"),R=s("el-pagination");return p(),f("div",O,[g("div",Q,[e(D,{inline:""},{default:n(()=>[e(x,{label:"角色",class:"input-width"},{default:n(()=>[e(k,{modelValue:o.roleId,"onUpdate:modelValue":l[0]||(l[0]=a=>o.roleId=a),placeholder:"请选择"},{default:n(()=>[(p(!0),f(z,null,S(y.value,a=>(p(),N(m,{key:a.id,label:a.name,value:a.id},null,8,["label","value"]))),128))]),_:1},8,["modelValue"])]),_:1}),e(x,{label:"状态",class:"input-width"},{default:n(()=>[e(k,{modelValue:o.status,"onUpdate:modelValue":l[1]||(l[1]=a=>o.status=a),placeholder:"请选择",clearable:""},{default:n(()=>[e(m,{label:"启用",value:1}),e(m,{label:"禁用",value:0})]),_:1},8,["modelValue"])]),_:1})]),_:1})]),g("div",W,[e(d,{icon:"Search",onClick:u},{default:n(()=>[r("查询")]),_:1}),e(d,{type:"info",icon:"Refresh",onClick:B},{default:n(()=>[r("重置")]),_:1}),e(d,{type:"primary",icon:"Plus",onClick:l[2]||(l[2]=a=>t.$router.push("/system/user/add"))},{default:n(()=>[r("新增用户")]),_:1}),e(d,{type:"danger",icon:"Delete",onClick:V},{default:n(()=>[r("批量删除")]),_:1})]),e(A,{data:b.value,onSelectionChange:U},{default:n(()=>[e(i,{type:"selection",width:"55"}),e(i,{type:"index",label:"序号",width:"80"}),e(i,{prop:"username",label:"用户名"}),e(i,{prop:"email",label:"邮箱"}),e(i,{prop:"roles",label:"角色"},{default:n(({row:a})=>[(p(!0),f(z,null,S(a.roles,c=>(p(),N(P,{type:c.createBy===a.username?"primary":"danger",key:c.id,class:"t-box"},{default:n(()=>[r(M(c.name),1)]),_:2},1032,["type"]))),128))]),_:1}),e(i,{prop:"createBy",label:"创建人"}),e(i,{prop:"createTime",label:"创建时间"}),e(i,{label:"操作"},{default:n(({row:a})=>[e(d,{type:"text",icon:"User",onClick:c=>t.$router.push(`/system/user/detail/${a.id}`)},{default:n(()=>[r("详细")]),_:2},1032,["onClick"]),e(d,{type:"text",icon:"Edit",onClick:c=>t.$router.push(`/system/user/edit/${a.id}`)},{default:n(()=>[r("编辑")]),_:2},1032,["onClick"]),e(d,{type:"text",icon:"Delete",onClick:c=>$(a)},{default:n(()=>[r("删除")]),_:2},1032,["onClick"])]),_:1})]),_:1},8,["data"]),g("div",X,[e(R,{"current-page":o.pageNum,"onUpdate:currentPage":l[3]||(l[3]=a=>o.pageNum=a),"page-size":o.pageSize,"onUpdate:pageSize":l[4]||(l[4]=a=>o.pageSize=a),"page-sizes":[10,20,50,100],layout:"prev, pager, next,jumper,->, sizes,total",total:v.value,background:"",onSizeChange:w,onCurrentChange:L},null,8,["current-page","page-size","total"])])])}}},ne=E(Y,[["__scopeId","data-v-a0939684"]]);export{ne as default};
