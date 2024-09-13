import{j as P,r as o,o as r,c as h,k as q,F as $,C as w,w as t,b as d,t as S,a as e,I as C,J as D,D as U,K as ee,h as y,_ as k,d as c,s as te,p as Z,g as G,u as z,G as ne,H as oe,e as B,E as A,l as F,v as H,L as le,T as se,M as ce,n as N}from"./index-C5uf1WvN.js";const ae={name:"AppMenu"},re=Object.assign(ae,{props:{menus:{type:Array,default:()=>[]}},setup(a){const s=P();let n;function u(l){l.link===0?s.push(l.url):(n||(n=document.createElement("a"),n.href=l.url,n.target="_blank"),n.click())}function p(l){if(l&&l.length==0)return!0;if(console.log(l),l instanceof Array){for(const i of l)if(i.type!==2)return!0}return!1}return(l,i)=>{const g=o("el-icon"),x=o("el-menu-item"),m=o("AppMenu"),f=o("el-sub-menu");return r(!0),h($,null,q(a.menus,_=>(r(),h($,null,[p(_.children)?(r(),w(f,{key:1,index:_.url},{title:t(()=>[e(g,null,{default:t(()=>[(r(),w(C(_.icon)))]),_:2},1024),d("span",null,S(_.title),1)]),default:t(()=>[e(m,{menus:_.children},null,8,["menus"])]),_:2},1032,["index"])):(r(),h($,{key:0},[_.type!==2?(r(),w(x,{key:0,index:_.url,onClick:I=>u(_)},{title:t(()=>[d("span",null,S(_.title),1)]),default:t(()=>[e(g,null,{default:t(()=>[(r(),w(C(_.icon)))]),_:2},1024)]),_:2},1032,["index","onClick"])):D("",!0)],64))],64))),256)}}});function ue(){return U({url:"/setting",method:"get",params:{id:1}})}function ie(a){return U({url:"/setting",method:"put",data:a})}const M=ee("setting",()=>{const a=y(!1),s=y(!1),n=y(!1),u=y({permissionMode:0});async function p(){return(await ie(u.value)).code===200?"ok":Promise.reject(new Error("更新设置失败"))}async function l(){const i=await ue();return i.code===200?(u.value=i.data,"ok"):Promise.reject(new Error("获取设置失败"))}return{fold:a,theme:s,refresh:n,getSetting:l,setting:u,updateSetting:p}}),_e="data:image/svg+xml,%3csvg%20xmlns='http://www.w3.org/2000/svg'%20xmlns:xlink='http://www.w3.org/1999/xlink'%20aria-hidden='true'%20role='img'%20class='iconify%20iconify--logos'%20width='37.07'%20height='36'%20preserveAspectRatio='xMidYMid%20meet'%20viewBox='0%200%20256%20198'%3e%3cpath%20fill='%2341B883'%20d='M204.8%200H256L128%20220.8L0%200h97.92L128%2051.2L157.44%200h47.36Z'%3e%3c/path%3e%3cpath%20fill='%2341B883'%20d='m0%200l128%20220.8L256%200h-51.2L128%20132.48L50.56%200H0Z'%3e%3c/path%3e%3cpath%20fill='%2335495E'%20d='M50.56%200L128%20133.12L204.8%200h-47.36L128%2051.2L97.92%200H50.56Z'%3e%3c/path%3e%3c/svg%3e",de=a=>(Z("data-v-c103f5bd"),a=a(),G(),a),pe={class:"logo-main"},me=de(()=>d("img",{src:_e},null,-1)),fe={__name:"index",setup(a){return(s,n)=>(r(),h("div",pe,[me,d("span",null,S(c(te).logoTitle),1)]))}},he=k(fe,[["__scopeId","data-v-c103f5bd"]]),ge={class:"top-right"},ve={href:"http://114.132.249.233/",target:"_blank",title:"文档",class:"github"},we={href:"https://github.com/X-hongquan/fast-admin",target:"_blank",title:"Github",class:"github"},xe=["src"],be={__name:"index",setup(a){const s=z(),n=M(),u=P(),p=ne();async function l(){await s.logout(),u.push({path:"/login",query:{redirect:p.path}}),A({type:"success",title:"提示",message:"退出成功"})}function i(){u.push({path:"/person"})}function g(){document.fullscreenElement?document.exitFullscreen():document.documentElement.requestFullscreen()}function x(){document.documentElement.className=n.theme?"dark":""}function m(){document.documentElement.style.setProperty("--el-color-primary",f.value)}const f=y();async function _(){try{await n.getSetting()}catch{A({type:"error",title:"提示",message:"获取设置失败"})}}async function I(){try{await n.updateSetting()}catch{A({type:"error",title:"提示",message:"更新设置失败"})}}return oe(()=>{_()}),(L,v)=>{const T=o("SvgIcon"),E=o("el-button"),J=o("el-color-picker"),V=o("el-form-item"),R=o("el-switch"),K=o("el-form"),O=o("el-popover"),X=o("arrow-down"),Y=o("el-icon"),j=o("el-dropdown-item"),Q=o("el-dropdown-menu"),W=o("el-dropdown");return r(),h("div",ge,[d("a",ve,[e(T,{name:"document",height:"25px",width:"25px"})]),d("a",we,[e(T,{name:"github",height:"25px",width:"25px"})]),e(E,{icon:"Refresh",circle:"",onClick:v[0]||(v[0]=b=>c(n).refresh=!c(n).refresh)}),e(E,{icon:"FullScreen",circle:"",onClick:g}),e(O,{placement:"bottom",title:"设置",width:300,trigger:"hover"},{default:t(()=>[e(K,{"label-width":"80px"},{default:t(()=>[e(V,{label:"主题色"},{default:t(()=>[e(J,{modelValue:f.value,"onUpdate:modelValue":v[1]||(v[1]=b=>f.value=b),onChange:m,"show-alpha":"",teleported:!1},null,8,["modelValue"])]),_:1}),e(V,{label:"暗黑模式"},{default:t(()=>[e(R,{modelValue:c(n).theme,"onUpdate:modelValue":v[2]||(v[2]=b=>c(n).theme=b),"active-icon":"Moon","inactive-icon":"Sunny",onChange:x},null,8,["modelValue"])]),_:1}),e(V,{label:"权限模式"},{default:t(()=>[e(R,{modelValue:c(n).setting.permissionMode,"onUpdate:modelValue":v[3]||(v[3]=b=>c(n).setting.permissionMode=b),"active-value":1,"inactive-value":0,"active-text":"封建家","inactive-text":"资本家",style:{"--el-switch-on-color":"#13ce66","--el-switch-off-color":"#ff4949"},onChange:I},null,8,["modelValue"])]),_:1})]),_:1})]),reference:t(()=>[e(E,{icon:"Setting",circle:""})]),_:1}),d("img",{src:c(s).userInfo.user.avatar,alt:"头像"},null,8,xe),e(W,null,{dropdown:t(()=>[e(Q,null,{default:t(()=>[e(j,{onClick:i},{default:t(()=>[B("个人中心")]),_:1}),e(j,{onClick:l},{default:t(()=>[B("退出登录")]),_:1})]),_:1})]),default:t(()=>[d("span",null,[B(S(c(s).userInfo.user.username)+" ",1),e(Y,null,{default:t(()=>[e(X)]),_:1})])]),_:1})])}}},ye=k(be,[["__scopeId","data-v-0769e959"]]),ke={class:"left"},Se={class:"mid-text"},$e={__name:"index",setup(a){const s=M();return(n,u)=>{const p=o("Expand"),l=o("el-icon"),i=o("Fold"),g=o("el-breadcrumb-item"),x=o("el-breadcrumb");return r(),h("div",ke,[F(e(l,{class:"icon",onClick:u[0]||(u[0]=m=>c(s).fold=!c(s).fold)},{default:t(()=>[e(p)]),_:1},512),[[H,!c(s).fold]]),F(e(l,{class:"icon",onClick:u[1]||(u[1]=m=>c(s).fold=!c(s).fold)},{default:t(()=>[e(i)]),_:1},512),[[H,c(s).fold]]),e(x,{"separator-icon":"ArrowRight"},{default:t(()=>[(r(!0),h($,null,q(n.$route.matched,(m,f)=>F((r(),w(g,{key:f,to:m.path},{default:t(()=>[e(l,{class:"mid-icon"},{default:t(()=>[(r(),w(C(m.meta.icon)))]),_:2},1024),d("span",Se,S(m.meta.title),1)]),_:2},1032,["to"])),[[H,m.meta.title]])),128))]),_:1})])}}},Ce=k($e,[["__scopeId","data-v-6c66e742"]]),Me={class:"tabBar"},Ie={__name:"index",setup(a){return(s,n)=>(r(),h("div",Me,[e(Ce),e(ye)]))}},Le=k(Ie,[["__scopeId","data-v-3a978c93"]]),Ee={__name:"index",setup(a){const s=M(),n=y(!0);return le(()=>s.refresh,()=>{n.value=!1,ce(()=>{n.value=!0})}),(u,p)=>{const l=o("router-view");return r(),w(l,null,{default:t(({Component:i})=>[e(se,{name:"fade"},{default:t(()=>[n.value?(r(),w(C(i),{key:0})):D("",!0)]),_:2},1024)]),_:1})}}},Ve=k(Ee,[["__scopeId","data-v-12914f6f"]]),Be=a=>(Z("data-v-014c8288"),a=a(),G(),a),Ae={class:"layout-container"},Fe={class:"layout-aside-logo"},He=Be(()=>d("span",null,"首页",-1)),Ne={__name:"index",setup(a){const s=P();function n(l){s.push(l)}const u=z(),p=M();return(l,i)=>{const g=o("HomeFilled"),x=o("el-icon"),m=o("el-menu-item"),f=o("el-menu"),_=o("el-scrollbar");return r(),h("div",Ae,[d("div",{class:N(["layout-aside",{fold:c(p).fold}])},[d("div",Fe,[e(he)]),e(_,{class:"scrollbar"},{default:t(()=>[e(f,{"background-color":"#001529","text-color":"#fff","default-active":l.$route.path,collapse:c(p).fold,"collapse-transition":!0},{default:t(()=>[e(m,{index:"/home",onClick:i[0]||(i[0]=I=>n("/home"))},{title:t(()=>[He]),default:t(()=>[e(x,null,{default:t(()=>[e(g)]),_:1})]),_:1}),e(re,{menus:c(u).menus},null,8,["menus"])]),_:1},8,["default-active","collapse"])]),_:1})],2),d("div",{class:N(["layout-header",{fold:c(p).fold}])},[e(Le)],2),d("div",{class:N(["layout-main",{fold:c(p).fold}])},[e(Ve)],2)])}}},Te=k(Ne,[["__scopeId","data-v-014c8288"]]);export{Te as default};
