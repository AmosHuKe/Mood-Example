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


(()=>{var f=Object.create;var u=Object.defineProperty;var m=Object.getOwnPropertyDescriptor;var w=Object.getOwnPropertyNames;var I=Object.getPrototypeOf,D=Object.prototype.hasOwnProperty;var L=(e,t)=>()=>(t||e((t={exports:{}}).exports,t),t.exports);var y=(e,t,s,n)=>{if(t&&typeof t=="object"||typeof t=="function")for(let o of w(t))!D.call(e,o)&&o!==s&&u(e,o,{get:()=>t[o],enumerable:!(n=m(t,o))||n.enumerable});return e};var p=(e,t,s)=>(s=e!=null?f(I(e)):{},y(t||!e||!e.__esModule?u(s,"default",{value:e,enumerable:!0}):s,e));var d=L((S,c)=>{c.exports=Vue});var A=p(d());function h(e,t,...s){uni.__log__?uni.__log__(e,t,...s):console[e].apply(console,[...s,t])}var i=p(d());var v=(e,t)=>{let s=e.__vccOpts||e;for(let[n,o]of t)s[n]=o;return s};var C={page:{"":{flex:1}},swiper:{"":{flex:1,backgroundColor:"#007AFF"}},"swiper-item":{"":{flex:1}},video:{"":{flex:1}}},b=[{src:"https://img.cdn.aliyun.dcloud.net.cn/guide/uniapp/hellouniapp/hello-nvue-swiper-vertical-01.mp4"},{src:"https://img.cdn.aliyun.dcloud.net.cn/guide/uniapp/hellouniapp/hello-nvue-swiper-vertical-02.mp4"},{src:"https://img.cdn.aliyun.dcloud.net.cn/guide/uniapp/hellouniapp/hello-nvue-swiper-vertical-03.mp4"},{src:"https://img.cdn.aliyun.dcloud.net.cn/guide/uniapp/hellouniapp/hello-nvue-swiper-vertical-01.mp4"},{src:"https://img.cdn.aliyun.dcloud.net.cn/guide/uniapp/hellouniapp/hello-nvue-swiper-vertical-02.mp4"},{src:"https://img.cdn.aliyun.dcloud.net.cn/guide/uniapp/hellouniapp/hello-nvue-swiper-vertical-03.mp4"}],V={data(){return{circular:!0,videoList:[{id:"video0",src:"",img:""},{id:"video1",src:"",img:""},{id:"video2",src:"",img:""}],videoDataList:[]}},onLoad(e){},onReady(){this.init(),this.getData()},methods:{init(){this._videoIndex=0,this._videoContextList=[];for(var e=0;e<this.videoList.length;e++)this._videoContextList.push(uni.createVideoContext("video"+e,this));this._videoDataIndex=0},getData(e){this.videoDataList=b,setTimeout(()=>{this.updateVideo(!0)},200)},onSwiperChange(e){let t=e.detail.current;if(t===this._videoIndex)return;let s=!1;t===0&&this._videoIndex===this.videoList.length-1?s=!0:t===this.videoList.length-1&&this._videoIndex===0?s=!1:t>this._videoIndex&&(s=!0),s?this._videoDataIndex++:this._videoDataIndex--,this._videoDataIndex<0?this._videoDataIndex=this.videoDataList.length-1:this._videoDataIndex>=this.videoDataList.length&&(this._videoDataIndex=0),this.circular=this._videoDataIndex!=0,this._videoIndex>=0&&(this._videoContextList[this._videoIndex].pause(),this._videoContextList[this._videoIndex].seek(0)),this._videoIndex=t,setTimeout(()=>{this.updateVideo(s)},200)},getNextIndex(e){let t=this._videoIndex+(e?1:-1);return t<0?this.videoList.length-1:t>=this.videoList.length?0:t},getNextDataIndex(e){let t=this._videoDataIndex+(e?1:-1);return t<0?this.videoDataList.length-1:t>=this.videoDataList.length?0:t},updateVideo(e){this.$set(this.videoList[this._videoIndex],"src",this.videoDataList[this._videoDataIndex].src),this.$set(this.videoList[this.getNextIndex(e)],"src",this.videoDataList[this.getNextDataIndex(e)].src),setTimeout(()=>{this._videoContextList[this._videoIndex].play()},200),h("log","at pages/template/swiper-vertical/swiper-vertical.nvue:139","v:"+this._videoIndex+" d:"+this._videoDataIndex+"; next v:"+this.getNextIndex(e)+" next d:"+this.getNextDataIndex(e))}}};function N(e,t,s,n,o,_){let g=(0,i.resolveComponent)("swiper-item"),x=(0,i.resolveComponent)("swiper");return(0,i.openBlock)(),(0,i.createElementBlock)("scroll-view",{scrollY:!0,showScrollbar:!0,enableBackToTop:!0,bubble:"true",style:{flexDirection:"column"}},[(0,i.createElementVNode)("view",{class:"page"},[(0,i.createVNode)(x,{class:"swiper",circular:o.circular,vertical:!0,onChange:_.onSwiperChange},{default:(0,i.withCtx)(()=>[((0,i.openBlock)(!0),(0,i.createElementBlock)(i.Fragment,null,(0,i.renderList)(o.videoList,r=>((0,i.openBlock)(),(0,i.createBlock)(g,{key:r.id},{default:(0,i.withCtx)(()=>[(0,i.createElementVNode)("u-video",{class:"video",id:r.id,ref_for:!0,ref:r.id,src:r.src,controls:!1,loop:!0,showCenterPlayBtn:!1},null,8,["id","src"])]),_:2},1024))),128))]),_:1},8,["circular","onChange"])])])}var a=v(V,[["render",N],["styles",[C]]]);var l=plus.webview.currentWebview();if(l){let e=parseInt(l.id),t="pages/template/swiper-vertical/swiper-vertical",s={};try{s=JSON.parse(l.__query__)}catch(o){}a.mpType="page";let n=Vue.createPageApp(a,{$store:getApp({allowDefault:!0}).$store,__pageId:e,__pagePath:t,__pageQuery:s});n.provide("__globalStyles",Vue.useCssStyles([...__uniConfig.styles,...a.styles||[]])),n.mount("#root")}})();
