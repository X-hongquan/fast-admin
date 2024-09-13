import{g as R,a as $,u as L,b as M,d as T}from"./index-B7ISXk8i.js";import{h as F}from"./confirm-CxKUQBJO.js";import{u as H,a as G,d as J}from"./notification-DhcrVVnz.js";import{h as m,i as b,H as K,r as s,o as Q,c as W,b as f,a as e,w as n,e as p,B as X}from"./index-C5uf1WvN.js";const Y={class:"content-box"},Z={class:"search-box"},ee={class:"operation-box"},te={class:"pagination-box"},oe={class:"dialog-footer"},de={__name:"index",setup(ae){const y=m([]),i=b({pageNum:1,pageSize:10,code:void 0,roleId:void 0,status:void 0}),d=m(!1),_=m(""),l=b({id:void 0,code:void 0,description:void 0}),C=m(0),g=m([]);async function w(t){g.value=t}const P=b({code:[{required:!0,message:"请输入权限值",trigger:"blur"}],description:[{required:!0,message:"请输入权限描述",trigger:"blur"}]});async function r(){const t=await R(i);t.code===200&&(y.value=t.data,C.value=Number(t.total))}function h(t){F(async()=>{const o=await T(t);J(o,()=>{r()})})}const V=m(null);function N(t){h([t.id])}function z(){g.value.length>0?h(g.value.map(t=>t.id)):X.error("请选择要删除的数据")}function S(t){i.pageNum=1,r()}function U(t){r()}function k(){Object.keys(l).forEach(t=>l[t]=void 0)}function A(){k(),d.value=!0,_.value="新增权限"}async function B(t){k(),d.value=!0,_.value="编辑权限";const o=await $(t.id);Object.assign(l,o.data)}async function I(){if(await V.value.validate(),l.id){const t=await L(l);H(t,()=>{r(),d.value=!1})}else{const t=await M(l);G(t,()=>{r(),d.value=!1})}}return K(()=>{r()}),(t,o)=>{const v=s("el-input"),u=s("el-button"),c=s("el-table-column"),q=s("el-table"),D=s("el-pagination"),x=s("el-form-item"),E=s("el-form"),j=s("el-dialog");return Q(),W("div",Y,[f("div",Z,[e(v,{modelValue:i.code,"onUpdate:modelValue":o[0]||(o[0]=a=>i.code=a),placeholder:"权限名",class:"input-width",clearable:""},null,8,["modelValue"]),e(u,{type:"primary",icon:"Search",onClick:r},{default:n(()=>[p("查询")]),_:1})]),f("div",ee,[e(u,{type:"primary",onClick:A},{default:n(()=>[p("新增")]),_:1}),e(u,{type:"danger",icon:"Delete",onClick:z},{default:n(()=>[p("批量删除")]),_:1})]),e(q,{data:y.value,onSelectionChange:w},{default:n(()=>[e(c,{type:"selection",width:"55"}),e(c,{label:"序号",type:"index",width:"80"}),e(c,{label:"权限值",prop:"code"}),e(c,{label:"描述",prop:"description"}),e(c,{prop:"createBy",label:"创建人"}),e(c,{prop:"createTime",label:"创建时间"}),e(c,{label:"操作",width:"300"},{default:n(({row:a})=>[e(u,{type:"text",icon:"Edit",onClick:O=>B(a)},{default:n(()=>[p("编辑")]),_:2},1032,["onClick"]),e(u,{type:"text",icon:"Delete",onClick:O=>N(a)},{default:n(()=>[p("删除")]),_:2},1032,["onClick"])]),_:1})]),_:1},8,["data"]),f("div",te,[e(D,{"current-page":i.pageNum,"onUpdate:currentPage":o[1]||(o[1]=a=>i.pageNum=a),"page-size":i.pageSize,"onUpdate:pageSize":o[2]||(o[2]=a=>i.pageSize=a),"page-sizes":[10,20,50,100],layout:"prev, pager, next,jumper,->, sizes,total",total:C.value,background:"",onSizeChange:S,onCurrentChange:U},null,8,["current-page","page-size","total"])]),e(j,{modelValue:d.value,"onUpdate:modelValue":o[6]||(o[6]=a=>d.value=a),title:_.value},{footer:n(()=>[f("span",oe,[e(u,{onClick:o[5]||(o[5]=a=>d.value=!1)},{default:n(()=>[p("取 消")]),_:1}),e(u,{type:"primary",onClick:I},{default:n(()=>[p("确 定")]),_:1})])]),default:n(()=>[e(E,{model:l,rules:P,"label-width":"80px",ref_key:"formRef",ref:V},{default:n(()=>[e(x,{label:"权限值",required:"",prop:"code"},{default:n(()=>[e(v,{modelValue:l.code,"onUpdate:modelValue":o[3]||(o[3]=a=>l.code=a)},null,8,["modelValue"])]),_:1}),e(x,{label:"权限描述",required:"",prop:"description"},{default:n(()=>[e(v,{modelValue:l.description,"onUpdate:modelValue":o[4]||(o[4]=a=>l.description=a)},null,8,["modelValue"])]),_:1})]),_:1},8,["model","rules"])]),_:1},8,["modelValue","title"])])}}};export{de as default};
