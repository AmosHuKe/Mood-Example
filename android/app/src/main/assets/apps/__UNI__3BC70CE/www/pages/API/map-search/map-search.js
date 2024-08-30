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


(()=>{var v=Object.create;var d=Object.defineProperty;var y=Object.getOwnPropertyDescriptor;var b=Object.getOwnPropertyNames;var w=Object.getPrototypeOf,x=Object.prototype.hasOwnProperty;var S=(e,t)=>()=>(t||e((t={exports:{}}).exports,t),t.exports);var k=(e,t,o,s)=>{if(t&&typeof t=="object"||typeof t=="function")for(let a of b(t))!x.call(e,a)&&a!==o&&d(e,a,{get:()=>t[a],enumerable:!(s=y(t,a))||s.enumerable});return e};var m=(e,t,o)=>(o=e!=null?v(w(e)):{},k(t||!e||!e.__esModule?d(o,"default",{value:e,enumerable:!0}):o,e));var i=S((B,g)=>{g.exports=Vue});var I=m(i());function l(e,t,...o){uni.__log__?uni.__log__(e,t,...o):console[e].apply(console,[...o,t])}var r=m(i());var _=(e,t)=>{let o=e.__vccOpts||e;for(let[s,a]of t)o[s]=a;return o};var C={content:{"":{flex:1}},map:{"":{width:"750rpx",height:"500rpx",backgroundColor:"#000000"}},scrollview:{"":{flex:1}},button:{"":{marginTop:"30rpx",marginBottom:"20rpx"}}},f=weex.requireModule("mapSearch"),N={data(){return{markers:[{id:"1",latitude:39.908692,longitude:116.397477,title:"\u5929\u5B89\u95E8",zIndex:"1",iconPath:"/static/gps.png",width:20,height:20,anchor:{x:.5,y:1},callout:{content:`\u9996\u90FD\u5317\u4EAC
\u5929\u5B89\u95E8`,color:"#00BFFF",fontSize:12,borderRadius:2,borderWidth:0,borderColor:"#333300",bgColor:"#CCFF11",padding:"1",display:"ALWAYS"}}]}},methods:{selectPoint(e){l("log","at pages/API/map-search/map-search.nvue:46",e)},reverseGeocode(){var e=this.markers[0];f.reverseGeocode({point:{latitude:e.latitude,longitude:e.longitude}},t=>{l("log","at pages/API/map-search/map-search.nvue:56",JSON.stringify(t)),uni.showModal({content:JSON.stringify(t)})})},poiSearchNearBy(){var e=this.markers[0];f.poiSearchNearBy({point:{latitude:e.latitude,longitude:e.longitude},key:"\u505C\u8F66\u573A",radius:1e3},t=>{l("log","at pages/API/map-search/map-search.nvue:72",t),uni.showModal({content:JSON.stringify(t)})})}}};function A(e,t,o,s,a,n){let u=(0,r.resolveComponent)("button");return(0,r.openBlock)(),(0,r.createElementBlock)("scroll-view",{scrollY:!0,showScrollbar:!0,enableBackToTop:!0,bubble:"true",style:{flexDirection:"column"}},[(0,r.createElementVNode)("view",{class:"content"},[(0,r.createElementVNode)("map",{class:"map",ref:"dcmap",markers:a.markers,onTap:t[0]||(t[0]=(...h)=>n.selectPoint&&n.selectPoint(...h))},null,40,["markers"]),(0,r.createElementVNode)("scroll-view",{class:"scrollview",scrollY:"true"},[(0,r.createVNode)(u,{class:"button",onClick:n.reverseGeocode},{default:(0,r.withCtx)(()=>[(0,r.createTextVNode)("reverseGeocode")]),_:1},8,["onClick"]),(0,r.createVNode)(u,{class:"button",onClick:n.poiSearchNearBy},{default:(0,r.withCtx)(()=>[(0,r.createTextVNode)("poiSearchNearBy")]),_:1},8,["onClick"])])])])}var c=_(N,[["render",A],["styles",[C]]]);var p=plus.webview.currentWebview();if(p){let e=parseInt(p.id),t="pages/API/map-search/map-search",o={};try{o=JSON.parse(p.__query__)}catch(a){}c.mpType="page";let s=Vue.createPageApp(c,{$store:getApp({allowDefault:!0}).$store,__pageId:e,__pagePath:t,__pageQuery:o});s.provide("__globalStyles",Vue.useCssStyles([...__uniConfig.styles,...c.styles||[]])),s.mount("#root")}})();
