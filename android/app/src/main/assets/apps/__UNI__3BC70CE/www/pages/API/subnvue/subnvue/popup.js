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


(()=>{var _=Object.create;var d=Object.defineProperty;var b=Object.getOwnPropertyDescriptor;var y=Object.getOwnPropertyNames;var h=Object.getPrototypeOf,v=Object.prototype.hasOwnProperty;var C=(r,e)=>()=>(e||r((e={exports:{}}).exports,e),e.exports);var w=(r,e,o,p)=>{if(e&&typeof e=="object"||typeof e=="function")for(let n of y(e))!v.call(r,n)&&n!==o&&d(r,n,{get:()=>e[n],enumerable:!(p=b(e,n))||p.enumerable});return r};var g=(r,e,o)=>(o=r!=null?_(h(r)):{},w(e||!r||!r.__esModule?d(o,"default",{value:r,enumerable:!0}):o,r));var a=C((L,x)=>{x.exports=Vue});var V=g(a());function u(){return uni.getSubNVueById(plus.webview.currentWebview().id)}var t=g(a());var f=(r,e)=>{let o=r.__vccOpts||r;for(let[p,n]of e)o[p]=n;return o};var B={wrapper:{"":{flexDirection:"column",justifyContent:"space-between",paddingTop:"10rpx",paddingRight:"15rpx",paddingBottom:"10rpx",paddingLeft:"15rpx",backgroundColor:"#F4F5F6",borderRadius:"4rpx"}},title:{"":{height:"100rpx",lineHeight:"100rpx",borderBottomStyle:"solid",borderBottomWidth:"1rpx",borderBottomColor:"#CBCBCB",flex:0,fontSize:"30rpx"}},scroller:{"":{height:"400rpx",paddingTop:"8rpx",paddingRight:"15rpx",paddingBottom:"8rpx",paddingLeft:"15rpx"}},content:{"":{color:"#555555",fontSize:"32rpx"}},"message-wrapper":{"":{flex:0,borderTopStyle:"solid",borderTopWidth:"1rpx",borderTopColor:"#CBCBCB",height:"80rpx",alignItems:"flex-end"}},"send-message":{"":{fontSize:"30rpx",lineHeight:"80rpx",color:"#00CE47",marginLeft:"20rpx"}},cell:{"":{marginTop:"10rpx",marginRight:"10rpx",marginBottom:"10rpx",marginLeft:"10rpx",paddingTop:"20rpx",paddingRight:0,paddingBottom:"20rpx",paddingLeft:0,top:"10rpx",alignItems:"center",justifyContent:"center",borderRadius:"10rpx",backgroundColor:"#5989B9"}},text:{"":{fontSize:"30rpx",textAlign:"center",color:"#FFFFFF"}}},S={data(){return{title:"",content:"",lists:[]}},created(){let r=this;for(let e=1;e<20;e++)this.lists.push("item"+e);uni.$on("page-popup",e=>{r.title=e.title,r.content=e.content})},beforeDestroy(){uni.$off("drawer-page")},methods:{sendMessage(){u(),uni.$emit("popup-page",{title:"\u5DF2\u8BFB\u5B8C!"})},handle(r,e){u(),uni.$emit("popup-page",{type:"interactive",info:r+" \u8BE5\u5143\u7D20\u88AB\u70B9\u51FB\u4E86!"})}}};function k(r,e,o,p,n,l){return(0,t.openBlock)(),(0,t.createElementBlock)("scroll-view",{scrollY:!0,showScrollbar:!0,enableBackToTop:!0,bubble:"true",style:{flexDirection:"column"}},[(0,t.createElementVNode)("div",{class:"wrapper"},[(0,t.createElementVNode)("u-text",{class:"title"},(0,t.toDisplayString)(n.title),1),(0,t.createElementVNode)("scroller",{class:"scroller"},[(0,t.createElementVNode)("div",null,[(0,t.createElementVNode)("u-text",{class:"content"},(0,t.toDisplayString)(n.content),1)]),(0,t.createElementVNode)("div",null,[(0,t.createElementVNode)("u-text",{style:{color:"red","font-size":"30rpx"}},"\u4EE5\u4E0B\u4E3A Popup \u5185\u90E8\u6EDA\u52A8\u793A\u4F8B\uFF1A")]),((0,t.openBlock)(!0),(0,t.createElementBlock)(t.Fragment,null,(0,t.renderList)(n.lists,(s,m)=>((0,t.openBlock)(),(0,t.createElementBlock)("div",{class:"cell",onClick:F=>l.handle(s),key:m},[(0,t.createElementVNode)("u-text",{class:"text"},(0,t.toDisplayString)(s),1)],8,["onClick"]))),128))]),(0,t.createElementVNode)("div",{class:"message-wrapper"},[(0,t.createElementVNode)("u-text",{class:"send-message",onClick:e[0]||(e[0]=(...s)=>l.sendMessage&&l.sendMessage(...s))},"\u5411\u9875\u9762\u53D1\u9001\u6D88\u606F")])])])}var i=f(S,[["render",k],["styles",[B]]]);var c=plus.webview.currentWebview();if(c){let r=parseInt(c.id),e="pages/API/subnvue/subnvue/popup",o={};try{o=JSON.parse(c.__query__)}catch(n){}i.mpType="page";let p=Vue.createPageApp(i,{$store:getApp({allowDefault:!0}).$store,__pageId:r,__pagePath:e,__pageQuery:o});p.provide("__globalStyles",Vue.useCssStyles([...__uniConfig.styles,...i.styles||[]])),p.mount("#root")}})();
