jQuery.extend({
    wxConfig : function(url) {
        $.ajax({
            type: "POST",
            url: "/getWxConfig.do",
            data : {"url" : encodeURIComponent(url)},
            dataType: "json",
            success: function(data) {
                wx.config({
                    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: 'wx8f4239ff75ca1770', // 必填，公众号的唯一标识
                    timestamp: data.timestamp, // 必填，生成签名的时间戳
                    nonceStr: data.nonceStr, // 必填，生成签名的随机串
                    signature: data.signature,// 必填，签名，见附录1
                    jsApiList: ['hideMenuItems', 'hideOptionMenu'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                });
                wx.error(function(res){
                    console.log("微信处理失败")
                });
            },
            error: function(){
                console.log("微信校验失败");
            }
        });
    },

    hideMenus : function (url) {
        jQuery.wxConfig(url);
        wx.ready(function(){
            //隐藏右上角菜单
            wx.hideOptionMenu();
            //批量隐藏功能按钮
            wx.hideMenuItems({
                menuList: ["menuItem:exposeArticle", "menuItem:setFont", "menuItem:refresh"]
            });
        });
    }
});