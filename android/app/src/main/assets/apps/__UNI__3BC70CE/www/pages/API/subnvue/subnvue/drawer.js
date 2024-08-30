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


(()=>{var m=Object.create;var d=Object.defineProperty;var _=Object.getOwnPropertyDescriptor;var b=Object.getOwnPropertyNames;var w=Object.getPrototypeOf,y=Object.prototype.hasOwnProperty;var v=(e,r)=>()=>(r||e((r={exports:{}}).exports,r),r.exports);var h=(e,r,o,n)=>{if(r&&typeof r=="object"||typeof r=="function")for(let i of b(r))!y.call(e,i)&&i!==o&&d(e,i,{get:()=>r[i],enumerable:!(n=_(r,i))||n.enumerable});return e};var c=(e,r,o)=>(o=e!=null?m(w(e)):{},h(r||!e||!e.__esModule?d(o,"default",{value:e,enumerable:!0}):o,e));var p=v((F,g)=>{g.exports=Vue});var V=c(p());function x(){return uni.getSubNVueById(plus.webview.currentWebview().id)}var t=c(p());var f=(e,r)=>{let o=e.__vccOpts||e;for(let[n,i]of r)o[n]=i;return o};var C={wrapper:{"":{flexDirection:"column",flex:1,textAlign:"center",paddingTop:"60rpx",paddingRight:"0rpx",paddingBottom:"0rpx",paddingLeft:"20rpx",backgroundColor:"#F4F5F6"}},"nav-text":{"":{color:"#8f8f94",marginBottom:"40rpx"}},"list-wrapper":{"":{height:"450rpx"}},"text-wrapper":{"":{justifyContent:"center",borderBottomStyle:"solid",borderBottomWidth:"1rpx",borderBottomColor:"rgba(0,0,0,0.2)",marginBottom:"35rpx",paddingBottom:"15rpx"}},"close-drawer":{"":{backgroundColor:"#f8f8f8",width:"300rpx",paddingTop:"15rpx",paddingRight:"15rpx",paddingBottom:"15rpx",paddingLeft:"15rpx",borderRadius:"20rpx",borderStyle:"solid",borderWidth:"1rpx",borderColor:"rgba(0,0,0,0.2)"}},icon:{"":{position:"absolute",right:"10rpx",color:"#000000",fontFamily:"unibtn",fontSize:"30rpx",fontWeight:"400"}}},k={data(){return{lists:[]}},beforeCreate(){weex.requireModule("dom").addRule("fontFace",{fontFamily:"unibtn",src:"url('../../../../static/uni.ttf')"})},created(){for(let e=0;e<5;e++)this.lists.push({id:e,name:"Item"+e})},methods:{hideDrawer(){x().hide("auto")},clickitem(e){uni.$emit("drawer-page",e)}}};function B(e,r,o,n,i,a){return(0,t.openBlock)(),(0,t.createElementBlock)("scroll-view",{scrollY:!0,showScrollbar:!0,enableBackToTop:!0,bubble:"true",style:{flexDirection:"column"}},[(0,t.createElementVNode)("div",{class:"wrapper"},[(0,t.createElementVNode)("u-text",{class:"nav-text"},"\u5DE6\u4FA7\u5217\u8868"),(0,t.createElementVNode)("list",{class:"list-wrapper"},[((0,t.openBlock)(!0),(0,t.createElementBlock)(t.Fragment,null,(0,t.renderList)(i.lists,s=>((0,t.openBlock)(),(0,t.createElementBlock)("cell",{key:s.id},[(0,t.createElementVNode)("div",{class:"text-wrapper",onClick:S=>a.clickitem(s.id)},[(0,t.createElementVNode)("u-text",{style:{"font-size":"30rpx"}},(0,t.toDisplayString)(s.name),1),(0,t.createElementVNode)("u-text",{class:"icon"},"\uE583")],8,["onClick"])]))),128))]),(0,t.createElementVNode)("div",{style:{flex:"1","text-align":"center"}},[(0,t.createElementVNode)("div",{class:"close-drawer",onClick:r[0]||(r[0]=(...s)=>a.hideDrawer&&a.hideDrawer(...s))},[(0,t.createElementVNode)("u-text",{style:{"font-size":"34rpx","text-align":"center"}},"\u5173\u95ED\u62BD\u5C49")])])])])}var l=f(k,[["render",B],["styles",[C]]]);var u=plus.webview.currentWebview();if(u){let e=parseInt(u.id),r="pages/API/subnvue/subnvue/drawer",o={};try{o=JSON.parse(u.__query__)}catch(i){}l.mpType="page";let n=Vue.createPageApp(l,{$store:getApp({allowDefault:!0}).$store,__pageId:e,__pagePath:r,__pageQuery:o});n.provide("__globalStyles",Vue.useCssStyles([...__uniConfig.styles,...l.styles||[]])),n.mount("#root")}})();
