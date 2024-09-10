import{l as F,s as G,a as K,g as Q,e as W,b as X,d as Z}from"./job-BmTBY0CP.js";import{h as ee}from"./confirm-fPFwdZqr.js";import{u as C,a as le,d as ae}from"./notification-D2_ThX_3.js";import{h as g,i as D,j as te,H as oe,r as u,o as _,c as ne,b as k,a as e,w as t,e as r,C as j,J as N}from"./index-C_vwRkRb.js";const de={class:"content-box"},ue={class:"search-box"},ie={class:"operation-box"},se={class:"pagination-box"},be={__name:"job",setup(re){const x=g([]),d=D({pageNum:1,pageSize:10,jobName:void 0,jobDesc:void 0,triggerStatus:void 0}),S=g(0),n=D({id:void 0,jobName:void 0,jobDesc:void 0,jobType:void 0,jobNextTime:void 0,nextTime:void 0,jobRate:void 0,jobCron:void 0,triggerStatus:0,triggerLastTime:void 0,remark:void 0,method:void 0,cron:void 0,createBy:void 0,createTime:void 0,updateBy:void 0,updateTime:void 0});g("");function U(){d.jobName=void 0,d.jobDesc=void 0,d.triggerStatus=void 0}async function m(){const o=await F(d);o.code===200&&(x.value=o.data,S.value=Number(o.total))}const h=g([]);function J(o){h.value=o}function w(){ee(async()=>{const o=h.value.map(p=>p.id),l=await Z(o);ae(l,()=>{m()})})}async function z(o){const l=await G(o);C(l,()=>{o.triggerStatus=1})}async function P(o){const l=await K(o);C(l,()=>{o.triggerStatus=0})}const f=g(!1),v=g("新增任务");function T(){Object.keys(n).forEach(o=>{n[o]=void 0}),n.triggerStatus=0}function A(){v.value="新增任务",f.value=!0,T()}async function q(o){v.value="编辑任务";const l=await Q(o.id);T(),Object.assign(n,l.data),f.value=!0}async function B(){if(n.id){const o=await W(n);C(o,()=>{m(),f.value=!1})}else{const o=await X(n);le(o,()=>{m(),f.value=!1})}}function R(o){d.pageNum=1,m()}function $(o){m()}const L=te();function Y(o){L.push({name:"scheduleLog",query:{jobName:o.jobName}})}return oe(()=>{m()}),(o,l)=>{const p=u("el-input"),i=u("el-form-item"),b=u("el-option"),V=u("el-select"),I=u("el-form"),s=u("el-button"),c=u("el-table-column"),E=u("el-table"),H=u("el-pagination"),M=u("el-date-picker"),O=u("el-dialog");return _(),ne("div",de,[k("div",ue,[e(I,{inline:""},{default:t(()=>[e(i,{label:"任务名称"},{default:t(()=>[e(p,{modelValue:d.jobName,"onUpdate:modelValue":l[0]||(l[0]=a=>d.jobName=a),placeholder:"请输入任务名称",clearable:""},null,8,["modelValue"])]),_:1}),e(i,{label:"任务描述"},{default:t(()=>[e(p,{modelValue:d.jobDesc,"onUpdate:modelValue":l[1]||(l[1]=a=>d.jobDesc=a),placeholder:"请输入任务描述",clearable:""},null,8,["modelValue"])]),_:1}),e(i,{label:"触发状态"},{default:t(()=>[e(V,{modelValue:d.triggerStatus,"onUpdate:modelValue":l[2]||(l[2]=a=>d.triggerStatus=a),placeholder:"请选择触发状态",clearable:"",class:"input-width"},{default:t(()=>[e(b,{label:"运行",value:1}),e(b,{label:"停止",value:0})]),_:1},8,["modelValue"])]),_:1})]),_:1})]),k("div",ie,[e(s,{icon:"Search",onClick:m},{default:t(()=>[r("查询")]),_:1}),e(s,{type:"primary",icon:"Plus",onClick:A},{default:t(()=>[r("新增")]),_:1}),e(s,{type:"info",icon:"refresh",onClick:U},{default:t(()=>[r("重置")]),_:1}),e(s,{type:"danger",icon:"Delete",onClick:w},{default:t(()=>[r("删除")]),_:1})]),e(E,{data:x.value,onSelectionChange:J},{default:t(()=>[e(c,{type:"selection",width:"55"}),e(c,{type:"index",label:"序号",width:"80"}),e(c,{prop:"jobName",label:"任务名"}),e(c,{prop:"jobDesc",label:"描述"}),e(c,{prop:"jobCron",label:"cron表达式"}),e(c,{prop:"nextTime",label:"下次执行时间"}),e(c,{prop:"jobRate",label:"周期(s)"}),e(c,{label:"操作"},{default:t(({row:a})=>[a.triggerStatus===0?(_(),j(s,{key:0,onClick:y=>z(a)},{default:t(()=>[r("启动")]),_:2},1032,["onClick"])):(_(),j(s,{key:1,type:"danger",onClick:y=>P(a)},{default:t(()=>[r("停止")]),_:2},1032,["onClick"])),e(s,{type:"text",onClick:y=>q(a)},{default:t(()=>[r("编辑")]),_:2},1032,["onClick"]),e(s,{type:"info",onClick:y=>Y(a)},{default:t(()=>[r("日志")]),_:2},1032,["onClick"])]),_:1})]),_:1},8,["data"]),k("div",se,[e(H,{"current-page":d.pageNum,"onUpdate:currentPage":l[3]||(l[3]=a=>d.pageNum=a),"page-size":d.pageSize,"onUpdate:pageSize":l[4]||(l[4]=a=>d.pageSize=a),"page-sizes":[10,20,50,100],layout:"prev, pager, next,jumper,->, sizes,total",total:S.value,background:"",onSizeChange:R,onCurrentChange:$},null,8,["current-page","page-size","total"])]),e(O,{modelValue:f.value,"onUpdate:modelValue":l[13]||(l[13]=a=>f.value=a),title:v.value,width:"500px"},{footer:t(()=>[e(s,{onClick:l[12]||(l[12]=a=>f.value=!1)},{default:t(()=>[r("取 消")]),_:1}),e(s,{type:"primary",onClick:B},{default:t(()=>[r("确 定")]),_:1})]),default:t(()=>[e(I,{"label-width":"80px"},{default:t(()=>[e(i,{label:"任务名称",required:""},{default:t(()=>[e(p,{modelValue:n.jobName,"onUpdate:modelValue":l[5]||(l[5]=a=>n.jobName=a),placeholder:"请输入任务名称",clearable:""},null,8,["modelValue"])]),_:1}),e(i,{label:"任务描述",required:""},{default:t(()=>[e(p,{type:"textarea",modelValue:n.jobDesc,"onUpdate:modelValue":l[6]||(l[6]=a=>n.jobDesc=a),placeholder:"请输入任务描述",clearable:""},null,8,["modelValue"])]),_:1}),e(i,{label:"触发状态"},{default:t(()=>[e(V,{modelValue:n.triggerStatus,"onUpdate:modelValue":l[7]||(l[7]=a=>n.triggerStatus=a),placeholder:"请选择触发状态",clearable:"",class:"input-width"},{default:t(()=>[e(b,{label:"正常",value:1}),e(b,{label:"暂停",value:0})]),_:1},8,["modelValue"])]),_:1}),e(i,{label:"模式",required:""},{default:t(()=>[e(V,{modelValue:n.jobType,"onUpdate:modelValue":l[8]||(l[8]=a=>n.jobType=a),placeholder:"请选择触发模式",clearable:"",class:"input-width"},{default:t(()=>[e(b,{label:"fixedRate",value:1}),e(b,{label:"cron",value:2})]),_:1},8,["modelValue"])]),_:1}),n.jobType==1?(_(),j(i,{key:0,label:"开始时间"},{default:t(()=>[e(M,{modelValue:n.nextTime,"onUpdate:modelValue":l[9]||(l[9]=a=>n.nextTime=a),type:"datetime",placeholder:"选择日期时间",clearable:"","value-format":"YYYY-MM-DD HH:mm:ss"},null,8,["modelValue"])]),_:1})):N("",!0),n.jobType==1?(_(),j(i,{key:1,label:"周期(s)",required:""},{default:t(()=>[e(p,{modelValue:n.jobRate,"onUpdate:modelValue":l[10]||(l[10]=a=>n.jobRate=a),placeholder:"请输入周期(s)",clearable:""},null,8,["modelValue"])]),_:1})):N("",!0),n.jobType==2?(_(),j(i,{key:2,label:"cron",required:""},{default:t(()=>[e(p,{modelValue:n.jobCron,"onUpdate:modelValue":l[11]||(l[11]=a=>n.jobCron=a),placeholder:"请输入cron表达式",clearable:""},null,8,["modelValue"])]),_:1})):N("",!0)]),_:1})]),_:1},8,["modelValue","title"])])}}};export{be as default};
