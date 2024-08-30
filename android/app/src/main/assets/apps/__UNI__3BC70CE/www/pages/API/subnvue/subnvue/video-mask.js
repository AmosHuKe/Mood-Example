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


(()=>{var d=Object.create;var p=Object.defineProperty;var _=Object.getOwnPropertyDescriptor;var g=Object.getOwnPropertyNames;var v=Object.getPrototypeOf,x=Object.prototype.hasOwnProperty;var h=(e,t)=>()=>(t||e((t={exports:{}}).exports,t),t.exports);var y=(e,t,o,r)=>{if(t&&typeof t=="object"||typeof t=="function")for(let n of g(t))!x.call(e,n)&&n!==o&&p(e,n,{get:()=>t[n],enumerable:!(r=_(t,n))||r.enumerable});return e};var b=(e,t,o)=>(o=e!=null?d(v(e)):{},y(t||!e||!e.__esModule?p(o,"default",{value:e,enumerable:!0}):o,e));var m=h((F,u)=>{u.exports=Vue});var s=b(m());var f=(e,t)=>{let o=e.__vccOpts||e;for(let[r,n]of t)o[r]=n;return o};var w={wrapper:{"":{position:"relative",flex:1,backgroundColor:"rgba(0,0,0,0)"}},list:{"":{position:"absolute",top:0,left:0,right:0,bottom:0,backgroundColor:"rgba(0,0,0,0.7)"}},cell:{"":{paddingTop:"10rpx",paddingRight:0,paddingBottom:"10rpx",paddingLeft:0,flexDirection:"row",flexWrap:"nowrap"}},name:{"":{flex:0,fontSize:"20rpx",marginRight:"20rpx",color:"#FF5A5F"}},content:{"":{flex:1,fontSize:"20rpx",color:"#F4F5F6"}}},k={data(){return{lists:[],interval:null,yourTexts:[{name:"\u5B66\u5458A",content:"\u8001\u5E08\u8BB2\u7684\u771F\u597D"},{name:"\u5B66\u5458B",content:"uni-app\u503C\u5F97\u5B66\u4E60"},{name:"\u5B66\u5458C",content:"\u8001\u5E08\uFF0C\u8FD8\u6709\u5B9E\u6218\u4F8B\u5B50\u5417\uFF1F"},{name:"\u5B66\u5458D",content:"\u8001\u5E08\uFF0C\u8BF7\u95EE\u662F\u4E0D\u662F\u8981\u5148\u5B66\u4F1Avue\u624D\u80FD\u5B66uni-app\uFF1F"},{name:"\u5B66\u5458E",content:"\u53D7\u6559\u4E86\uFF0Cuni-app\u592A\u725B\u4E86"}]}},created(){uni.$on("play-video",e=>{e.status==="open"?this.addItem():this.closeItem()})},beforeDestroy(){uni.$off("play-video"),this.closeItem()},methods:{addItem(){let e=this;e.lists=[{name:"\u5B66\u5458E",content:"\u53D7\u6559\u4E86\uFF0Cuni-app\u592A\u725B\u4E86"}];let t=weex.requireModule("dom");e.interval=setInterval(()=>{e.lists.length>15&&e.lists.unshift(),e.lists.push({name:e.yourTexts[e.lists.length%4].name,content:e.yourTexts[e.lists.length%4].content}),e.lists.length>5&&e.$nextTick(()=>{e.$refs["item"+(e.lists.length-1)]&&t.scrollToElement(e.$refs["item"+(e.lists.length-1)][0])})},3500)},closeItem(){this.interval&&clearInterval(this.interval)}}};function I(e,t,o,r,n,$){return(0,s.openBlock)(),(0,s.createElementBlock)("scroll-view",{scrollY:!0,showScrollbar:!0,enableBackToTop:!0,bubble:"true",style:{flexDirection:"column"}},[(0,s.createElementVNode)("div",{class:"wrapper"},[(0,s.createElementVNode)("list",{class:"list"},[((0,s.openBlock)(!0),(0,s.createElementBlock)(s.Fragment,null,(0,s.renderList)(n.lists,(i,c)=>((0,s.openBlock)(),(0,s.createElementBlock)("cell",{key:c,ref_for:!0,ref:"item"+c,class:"cell"},[(0,s.createElementVNode)("u-text",{class:"name"},(0,s.toDisplayString)(i.name)+":",1),(0,s.createElementVNode)("u-text",{class:"content"},(0,s.toDisplayString)(i.content),1)]))),128))])])])}var l=f(k,[["render",I],["styles",[w]]]);var a=plus.webview.currentWebview();if(a){let e=parseInt(a.id),t="pages/API/subnvue/subnvue/video-mask",o={};try{o=JSON.parse(a.__query__)}catch(n){}l.mpType="page";let r=Vue.createPageApp(l,{$store:getApp({allowDefault:!0}).$store,__pageId:e,__pagePath:t,__pageQuery:o});r.provide("__globalStyles",Vue.useCssStyles([...__uniConfig.styles,...l.styles||[]])),r.mount("#root")}})();
