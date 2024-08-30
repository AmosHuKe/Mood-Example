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


(()=>{var _=Object.create;var f=Object.defineProperty;var y=Object.getOwnPropertyDescriptor;var b=Object.getOwnPropertyNames;var x=Object.getPrototypeOf,k=Object.prototype.hasOwnProperty;var C=(t,n)=>()=>(n||t((n={exports:{}}).exports,n),n.exports);var w=(t,n,i,s)=>{if(n&&typeof n=="object"||typeof n=="function")for(let r of b(n))!k.call(t,r)&&r!==i&&f(t,r,{get:()=>n[r],enumerable:!(s=y(n,r))||s.enumerable});return t};var g=(t,n,i)=>(i=t!=null?_(x(t)):{},w(n||!t||!t.__esModule?f(i,"default",{value:t,enumerable:!0}):i,t));var d=C((O,m)=>{m.exports=Vue});var V=g(d());function u(t,n,...i){uni.__log__?uni.__log__(t,n,...i):console[t].apply(console,[...i,n])}var e=g(d());var v=(t,n)=>{let i=t.__vccOpts||t;for(let[s,r]of n)i[s]=r;return i};var S={video:{"":{width:"750rpx",height:"400rpx",backgroundColor:"#808080"}},btn:{"":{marginTop:5,marginBottom:5}}},h={data(){return{src:"https://qiniu-web-assets.dcloud.net.cn/unidoc/zh/2minute-demo.mp4",fil:!0,list:[{text:"\u8981\u663E\u793A\u7684\u6587\u672C",color:"#FF0000",time:9}]}},onReady(){this.context=uni.createVideoContext("video1",this)},methods:{onstart(t){u("log","at pages/component/video/video.nvue:36","onstart:"+JSON.stringify(t))},onpause(t){u("log","at pages/component/video/video.nvue:39","onpause:"+JSON.stringify(t))},onfinish(t){u("log","at pages/component/video/video.nvue:42","onfinish:"+JSON.stringify(t))},onfail(t){u("log","at pages/component/video/video.nvue:45","onfail:"+JSON.stringify(t))},fullscreenchange(t){u("log","at pages/component/video/video.nvue:48","fullscreenchange:"+JSON.stringify(t))},waiting(t){u("log","at pages/component/video/video.nvue:51","waiting:"+JSON.stringify(t))},timeupdate(t){u("log","at pages/component/video/video.nvue:54","timeupdate:"+JSON.stringify(t))},play(){this.context.play()},pause(){this.context.pause()},seek(){this.context.seek(20)},stop(){this.context.stop()},fullScreen(){this.context.requestFullScreen({direction:90})},exitFullScreen(){this.context.exitFullScreen()},sendDanmu(){this.context.sendDanmu({text:"\u8981\u663E\u793A\u7684\u5F39\u5E55\u6587\u672C",color:"#FF0000"})},playbackRate(){this.context.playbackRate(2)}}};function N(t,n,i,s,r,o){let a=(0,e.resolveComponent)("button");return(0,e.openBlock)(),(0,e.createElementBlock)("scroll-view",{scrollY:!0,showScrollbar:!0,enableBackToTop:!0,bubble:"true",style:{flexDirection:"column"}},[(0,e.createElementVNode)("div",null,[(0,e.createElementVNode)("u-video",{id:"video1",class:"video",src:r.src,autoplay:"false",duration:"",controls:"true",danmuList:r.list,danmuBtn:"true",enableDanmu:"true",loop:!0,muted:"true",initialTime:"",direction:"-90",showMuteBtn:"true",onPlay:n[0]||(n[0]=(...l)=>o.onstart&&o.onstart(...l)),onPause:n[1]||(n[1]=(...l)=>o.onpause&&o.onpause(...l)),onEnded:n[2]||(n[2]=(...l)=>o.onfinish&&o.onfinish(...l)),onError:n[3]||(n[3]=(...l)=>o.onfail&&o.onfail(...l)),onWaiting:n[4]||(n[4]=(...l)=>o.waiting&&o.waiting(...l)),onTimeupdate:n[5]||(n[5]=(...l)=>o.timeupdate&&o.timeupdate(...l)),onFullscreenchange:n[6]||(n[6]=(...l)=>o.fullscreenchange&&o.fullscreenchange(...l))},null,40,["src","danmuList"]),(0,e.createVNode)(a,{class:"btn",onClick:o.play},{default:(0,e.withCtx)(()=>[(0,e.createTextVNode)("\u64AD\u653E")]),_:1},8,["onClick"]),(0,e.createVNode)(a,{class:"btn",onClick:o.pause},{default:(0,e.withCtx)(()=>[(0,e.createTextVNode)("\u6682\u505C")]),_:1},8,["onClick"]),(0,e.createVNode)(a,{class:"btn",onClick:o.seek},{default:(0,e.withCtx)(()=>[(0,e.createTextVNode)("\u8DF3\u8F6C\u5230\u6307\u5B9A\u4F4D\u7F6E")]),_:1},8,["onClick"]),(0,e.createVNode)(a,{class:"btn",onClick:o.stop},{default:(0,e.withCtx)(()=>[(0,e.createTextVNode)("\u505C\u6B62")]),_:1},8,["onClick"]),(0,e.createVNode)(a,{class:"btn",onClick:o.fullScreen},{default:(0,e.withCtx)(()=>[(0,e.createTextVNode)("\u5168\u5C4F")]),_:1},8,["onClick"]),(0,e.createVNode)(a,{class:"btn",onClick:o.exitFullScreen},{default:(0,e.withCtx)(()=>[(0,e.createTextVNode)("\u9000\u51FA\u5168\u5C4F")]),_:1},8,["onClick"]),(0,e.createVNode)(a,{class:"btn",onClick:o.playbackRate},{default:(0,e.withCtx)(()=>[(0,e.createTextVNode)("\u8BBE\u7F6E\u500D\u901F")]),_:1},8,["onClick"]),(0,e.createVNode)(a,{class:"btn",onClick:o.sendDanmu},{default:(0,e.withCtx)(()=>[(0,e.createTextVNode)("\u53D1\u9001\u5F39\u5E55")]),_:1},8,["onClick"])])])}var c=v(h,[["render",N],["styles",[S]]]);var p=plus.webview.currentWebview();if(p){let t=parseInt(p.id),n="pages/component/video/video",i={};try{i=JSON.parse(p.__query__)}catch(r){}c.mpType="page";let s=Vue.createPageApp(c,{$store:getApp({allowDefault:!0}).$store,__pageId:t,__pagePath:n,__pageQuery:i});s.provide("__globalStyles",Vue.useCssStyles([...__uniConfig.styles,...c.styles||[]])),s.mount("#root")}})();
