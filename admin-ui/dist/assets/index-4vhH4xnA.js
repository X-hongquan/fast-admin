import{D as S,_ as N,u as U,j as q,G as B,i as w,h as d,H as E,c as T,a as e,w as t,r as s,o as D,b as m,t as P,d as R,s as j,e as A,E as y,p as F,g as G}from"./index-C_vwRkRb.js";import{g as H}from"./time-awypLf81.js";import{a as M,b as z}from"./validate-D2IKykPn.js";function J(){return S({url:"/captcha",method:"get"})}const K=r=>(F("data-v-ab239fc8"),r=r(),G(),r),L={class:"login-container"},O=K(()=>m("h1",null,"登录",-1)),Q=["src"],W={__name:"index",setup(r){const x=U(),v=q(),b=B(),o=w({username:"admin",password:"123456",key:"",captcha:""}),_=d(null),i=d(!1),k=w({username:[{validator:M,trigger:"change"}],password:[{validator:z,trigger:"change"}],captcha:[{required:!0,message:"请输入验证码",trigger:"change"}]});async function C(){await _.value.validate(),i.value=!0;try{await x.login(o);let a=b.query.redirect;v.push({path:a||"/"}),y({title:H(),message:"登录成功",type:"success"})}catch(a){y({title:"登录失败",message:a.message,type:"error"})}finally{i.value=!1}}const g=d("");async function f(){const l=await J();l.code===200&&(o.key=l.data.key),g.value="data:image/png;base64,"+l.data.img}return E(()=>{f()}),(l,a)=>{const c=s("el-col"),p=s("el-input"),u=s("el-form-item"),h=s("el-row"),V=s("el-button"),I=s("el-form");return D(),T("div",L,[e(h,null,{default:t(()=>[e(c,{span:12,xs:0}),e(c,{span:12,xs:24},{default:t(()=>[e(I,{class:"login-form",model:o,rules:k,ref_key:"loginComponent",ref:_},{default:t(()=>[O,m("h2",null,P(R(j).logoTitle),1),e(u,{prop:"username"},{default:t(()=>[e(p,{"prefix-icon":"user",class:"input-height",type:"text",placeholder:"请输入用户名",modelValue:o.username,"onUpdate:modelValue":a[0]||(a[0]=n=>o.username=n)},null,8,["modelValue"])]),_:1}),e(u,{prop:"password"},{default:t(()=>[e(p,{"prefix-icon":"lock",class:"input-height",type:"password",placeholder:"请输入密码",modelValue:o.password,"onUpdate:modelValue":a[1]||(a[1]=n=>o.password=n),"show-password":""},null,8,["modelValue"])]),_:1}),e(h,{gutter:50},{default:t(()=>[e(c,{span:12},{default:t(()=>[e(u,{prop:"captcha"},{default:t(()=>[e(p,{class:"input-width","prefix-icon":"CircleCheck",placeholder:"验证码",modelValue:o.captcha,"onUpdate:modelValue":a[2]||(a[2]=n=>o.captcha=n)},null,8,["modelValue"])]),_:1})]),_:1}),e(c,{span:12},{default:t(()=>[m("img",{src:g.value,onClick:f,style:{cursor:"pointer"}},null,8,Q)]),_:1})]),_:1}),e(u,null,{default:t(()=>[e(V,{loading:i.value,class:"login-btn input-box",type:"primary",onClick:C},{default:t(()=>[A("登录 ")]),_:1},8,["loading"])]),_:1})]),_:1},8,["model","rules"])]),_:1})]),_:1})])}}},$=N(W,[["__scopeId","data-v-ab239fc8"]]);export{$ as default};