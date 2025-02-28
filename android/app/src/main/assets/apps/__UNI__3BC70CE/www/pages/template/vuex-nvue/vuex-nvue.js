"use weex:vue";

if (typeof Promise !== 'undefined' && !Promise.prototype.finally) {
  Promise.prototype.finally = function(callback) {
    const promise = this.constructor
    return this.then(
      value => promise.resolve(callback()).then(() => value),
      reason => promise.resolve(callback()).then(() => {
        throw reason
      })
    )
  }
};

if (typeof uni !== 'undefined' && uni && uni.requireGlobal) {
  const global = uni.requireGlobal()
  ArrayBuffer = global.ArrayBuffer
  Int8Array = global.Int8Array
  Uint8Array = global.Uint8Array
  Uint8ClampedArray = global.Uint8ClampedArray
  Int16Array = global.Int16Array
  Uint16Array = global.Uint16Array
  Int32Array = global.Int32Array
  Uint32Array = global.Uint32Array
  Float32Array = global.Float32Array
  Float64Array = global.Float64Array
  BigInt64Array = global.BigInt64Array
  BigUint64Array = global.BigUint64Array
};


(()=>{var N=Object.create;var A=Object.defineProperty;var S=Object.getOwnPropertyDescriptor;var P=Object.getOwnPropertyNames;var V=Object.getPrototypeOf,E=Object.prototype.hasOwnProperty;var y=(e,t)=>()=>(t||e((t={exports:{}}).exports,t),t.exports);var O=(e,t,o,i)=>{if(t&&typeof t=="object"||typeof t=="function")for(let r of P(t))!E.call(e,r)&&r!==o&&A(e,r,{get:()=>t[r],enumerable:!(i=S(t,r))||i.enumerable});return e};var m=(e,t,o)=>(o=e!=null?N(V(e)):{},O(t||!e||!e.__esModule?A(o,"default",{value:e,enumerable:!0}):o,e));var h=(e,t,o)=>new Promise((i,r)=>{var s=l=>{try{c(o.next(l))}catch(_){r(_)}},u=l=>{try{c(o.throw(l))}catch(_){r(_)}},c=l=>l.done?i(l.value):Promise.resolve(l.value).then(s,u);c((o=o.apply(e,t)).next())});var g=y((q,w)=>{w.exports=Vue});var L=y((Q,k)=>{k.exports=uni.Vuex});var a=m(g());var d=(e,t)=>{let o=e.__vccOpts||e;for(let[i,r]of t)o[i]=r;return o};var W={name:"page-head",props:{title:{type:String,default:""}}};function I(e,t,o,i,r,s){return(0,a.openBlock)(),(0,a.createElementBlock)("view",{class:"common-page-head",renderWhole:!0},[(0,a.createElementVNode)("view",{class:"common-page-head-title"},[(0,a.createElementVNode)("u-text",null,(0,a.toDisplayString)(o.title),1)])])}var b=d(W,[["render",I]]);var n=m(g());var j=m(g());function v(e,t,...o){uni.__log__?uni.__log__(e,t,...o):console[e].apply(console,[...o,t])}function C(e,t){return typeof e=="string"?t:e}var T=m(L());var p=(0,T.createStore)({state:{hasLogin:!1,isUniverifyLogin:!1,loginProvider:"",openid:null,testvuex:!1,colorIndex:0,colorList:["#FF0000","#00FF00","#0000FF"],noMatchLeftWindow:!0,active:"componentPage",leftWinActive:"/pages/component/view/view",activeOpen:"",menu:[],univerifyErrorMsg:"",username:"foo",sex:"\u7537",age:10},mutations:{login(e,t){e.hasLogin=!0,e.loginProvider=t},logout(e){e.hasLogin=!1,e.openid=null},setOpenid(e,t){e.openid=t},setTestTrue(e){e.testvuex=!0},setTestFalse(e){e.testvuex=!1},setColorIndex(e,t){e.colorIndex=t},setMatchLeftWindow(e,t){e.noMatchLeftWindow=!t},setActive(e,t){e.active=t},setLeftWinActive(e,t){e.leftWinActive=t},setActiveOpen(e,t){e.activeOpen=t},setMenu(e,t){e.menu=t},setUniverifyLogin(e,t){typeof t!="boolean"&&(t=!!t),e.isUniverifyLogin=t},setUniverifyErrorMsg(e,t=""){e.univerifyErrorMsg=t},increment(e){e.age++},incrementTen(e,t){e.age+=t.amount},resetAge(e){e.age=10}},getters:{currentColor(e){return e.colorList[e.colorIndex]},doubleAge(e){return e.age*2}},actions:{incrementAsync(e,t){e.commit("incrementTen",t)},getUserOpenId:function(o){return h(this,arguments,function*({commit:e,state:t}){return yield new Promise((i,r)=>{t.openid?i(t.openid):uni.login({success:s=>{e("login"),setTimeout(function(){let u="123456789";v("log","at store/index.js:113","uni.request mock openid["+u+"]"),e("setOpenid",u),i(u)},1e3)},fail:s=>{v("log","at store/index.js:119","uni.login \u63A5\u53E3\u8C03\u7528\u5931\u8D25\uFF0C\u5C06\u65E0\u6CD5\u6B63\u5E38\u4F7F\u7528\u5F00\u653E\u63A5\u53E3\u7B49\u670D\u52A1",s),r(s)}})})})},getPhoneNumber:function({commit:e},t){return new Promise((o,i)=>{uni.request({url:"https://97fca9f2-41f6-449f-a35e-3f135d4c3875.bspapp.com/http/univerify-login",method:"POST",data:t,success:r=>{let s=r.data;s.success?o(s.phoneNumber):i(r)},fail:r=>{i(res)}})})}}}),M={data(){return{}},computed:{username(){return this.$store.state.username},sex(){return p.state.sex},age(){return p.state.age},doubleAge(){return p.getters.doubleAge}},methods:{addAge(){p.commit("increment")},addAgeTen(){p.commit("incrementTen",{amount:10})},addAgeAction(){p.dispatch("incrementAsync",{amount:20})},resetAge(){p.commit("resetAge")}}};function F(e,t,o,i,r,s){let u=C((0,n.resolveDynamicComponent)("page-head"),b),c=(0,n.resolveComponent)("button");return(0,n.openBlock)(),(0,n.createElementBlock)("scroll-view",{scrollY:!0,showScrollbar:!0,enableBackToTop:!0,bubble:"true",style:{flexDirection:"column"}},[(0,n.createElementVNode)("view",{class:"uni-product"},[(0,n.createVNode)(u,{title:"vuex:nvue\u9875\u9762"}),(0,n.createElementVNode)("u-text",{class:"username"},"\u7528\u6237\u540D\uFF1A"+(0,n.toDisplayString)(s.username),1),(0,n.createElementVNode)("u-text",{class:"sex"},"\u6027\u522B\uFF1A"+(0,n.toDisplayString)(s.sex),1),(0,n.createElementVNode)("view",{class:"age"},[(0,n.createElementVNode)("u-text",null,"\u5E74\u9F84\uFF1A"+(0,n.toDisplayString)(s.age),1)]),(0,n.createElementVNode)("view",{class:"doubleAge"},[(0,n.createElementVNode)("u-text",null,"\u5E74\u9F84\u7FFB\u500D\uFF1A"+(0,n.toDisplayString)(s.doubleAge),1)]),(0,n.createVNode)(c,{onClick:s.addAge},{default:(0,n.withCtx)(()=>[(0,n.createTextVNode)("\u589E\u52A01\u5C81")]),_:1},8,["onClick"]),(0,n.createVNode)(c,{onClick:s.addAgeTen},{default:(0,n.withCtx)(()=>[(0,n.createTextVNode)("\u589E\u52A010\u5C81")]),_:1},8,["onClick"]),(0,n.createVNode)(c,{onClick:s.addAgeAction},{default:(0,n.withCtx)(()=>[(0,n.createTextVNode)("\u589E\u52A020\u5C81")]),_:1},8,["onClick"]),(0,n.createVNode)(c,{onClick:s.resetAge},{default:(0,n.withCtx)(()=>[(0,n.createTextVNode)("\u91CD\u7F6E")]),_:1},8,["onClick"])])])}var f=d(M,[["render",F]]);var x=plus.webview.currentWebview();if(x){let e=parseInt(x.id),t="pages/template/vuex-nvue/vuex-nvue",o={};try{o=JSON.parse(x.__query__)}catch(r){}f.mpType="page";let i=Vue.createPageApp(f,{$store:getApp({allowDefault:!0}).$store,__pageId:e,__pagePath:t,__pageQuery:o});i.provide("__globalStyles",Vue.useCssStyles([...__uniConfig.styles,...f.styles||[]])),i.mount("#root")}})();
