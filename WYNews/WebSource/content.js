function extend_image(url,element){
    //不可点击的图片特殊处理,parent节点添加extend=no
    if (element.parentElement.parentElement.getAttribute('extend') == "no") {
        return;
    }

    var setid = element.parentElement.getAttribute("photoset");
    if(setid){
        location.href = "photoset:///"+setid;
        return;
    }
    var img=element.getElementsByTagName("IMG")[0];
    x=0;y=0;

    var imgId = element.parentElement.getAttribute("id");

    var showWidth = element.clientWidth;
    var showHeight = element.clientHeight;
    while( element != null ) {
        x += element.offsetLeft + element.clientLeft;
        y += element.offsetTop + element.clientTop;
        element = element.offsetParent;
    }


    location.href="image:///"+x+"///"+y+"///"+ window.pageYOffset +"///"+url+"///"+showWidth+"///"+showHeight + "///" + imgId;

}

function getLinkRect()
{
    var results = new Array();
    var links = document.getElementsByTagName('a');
    for (i = 0; i < links.length; i++)
    {
        var rect = links[i].getBoundingClientRect();
        results.push(rect);
    }
    var divs = document.getElementsByTagName('div');
    for (i = 0; i < divs.length; i++)
    {
        if (divs[i].className == 'photo_big' || divs[i].className.lastIndexOf('plugin', 0) === 0/*plugin开头*/)
        {
            var rect = divs[i].getBoundingClientRect();
            results.push(rect);
        }
    }
    var jsonString = JSON.stringify(results);
    return jsonString;
}

function getImageRect()
{
    var results = new Array();
    for (i = 0; ; i++)
    {
        var imageID = "image_" + i;
        var image = document.getElementById(imageID);
        if(image)
        {
            var rect = image.getBoundingClientRect(); 
            var theRect = new Object();
            theRect.bottom = rect.bottom;
            theRect.height = rect.height;
            theRect.left = rect.left;
            theRect.right = rect.right;
            theRect.top = rect.top + window.pageYOffset;
            theRect.width = rect.width;
            results[i] = theRect;

        } else {
            break;
        }
    }
    var jsonString = JSON.stringify(results);
    return jsonString;
}

function download_image(element){
    element.onclick = function() { return false; };
    element.innerHTML="<span> 下载中...</span>";
    location.href="downimage://" + element.parentElement.getAttribute("id").split('_')[1];
}

function image_loaded(element){
    element.className = 'loaded';
}

function play_video(url,boardcast,topicid,commentid,commentboardid,element){
    
    var rect = element.getBoundingClientRect();   
    location.href="video:///"+boardcast+"///" + url + "///" + topicid + "///" + commentid + "///"+ commentboardid + "///" + rect.left+ "///" + rect.top + "///" + rect.width+ "///" + rect.height;
}

function play_audio(url){
    location.href = "audio:///"+ url;
}

function open_map(pois){
    location.href = "amap://" +pois;
}

function sub_topic(element){
    var className = element.className;
    if(className=='topic_plus no_tc'){
        element.className = 'topic_check no_tc';
        location.href = "topic://sub//"+element.getAttribute("id").split('_')[2];
    }else{
        element.className = 'topic_plus no_tc';
        location.href = "topic://unsub//"+element.getAttribute("id").split('_')[2];
    }
    return false;
}

function onLoad(){
    //此处参考jquery实现，必须要调用两个remove哦，否则会走多次
   	document.removeEventListener( "DOMContentLoaded", onLoad, false );
    window.removeEventListener( "load", onLoad, false );
    
    //相关新闻
    var relative_section = document.getElementById('relative_section');
    if(relative_section){
        var myLinks = relative_section.getElementsByTagName('li');
        
        for(var i = 0; i < myLinks.length; i++){
            myLinks[i].addEventListener('touchstart', function(event){
                                            this.id = "hover";
                                        }, false);
            myLinks[i].addEventListener('touchend', function(){
                                            for(var j = 0; j < myLinks.length; j++){
                                                myLinks[j].id = ""
                                        }}, false);
            myLinks[i].addEventListener('click', function(event){
                                            this.firstChild.className="no_tc read";
                                        }, false);
        }
    }
    //处理新的推荐栏目
    var relative_topics = document.getElementsByClassName('relative_recommend');
    if(relative_topics && relative_topics.length){
        for (var i = 0; i < relative_topics.length; i++){
            relative_topics[i].addEventListener('click', function(event){
                                        location.href = "plugin:///" + this.getAttribute("url");
                                        }, false);
        }
    }
    
    //内嵌插件
    var plugins = document.getElementsByClassName('plugin');
    if(plugins && plugins.length){
        for(var i = 0; i < plugins.length; i++){
            if (plugins[i].getAttribute('subs')){
                //推荐栏目的订阅按钮
                addEventListenerToSubButton(plugins[i]);
            }else{
                plugins[i].addEventListener('touchstart', function(event){
                                                this.id = "hover";
                                            }, false);
                plugins[i].addEventListener('touchend', function(){
                                                this.id = "";
                                            }, false);
                plugins[i].addEventListener('click', function(event){
                                                location.href = "plugin:///" + this.getAttribute("url");
                                                }, false);
            }
        }
    }
    
    //广告插件
    var plugins = document.getElementsByClassName('ad_wrapper');
    if(plugins && plugins.length){
        for(var i = 0; i < plugins.length; i++){
            if(i==0){
                noFirstPageAD(plugins[i]);
            }
            plugins[i].addEventListener('touchstart', function(event){
                                        this.id = "hover";
                                        }, false);
            plugins[i].addEventListener('touchend', function(){
                                        this.id = "";
                                        }, false);
            plugins[i].addEventListener('click', function(event){
                                        location.href = "plugin:///" + this.getAttribute("url");
                                        }, false);
            
        }
    }

    
    //带颜色边框链接
    var links = document.getElementsByClassName('border_link');
    if(links && links.length){
        for(var i = 0; i < links.length; i++){
            links[i].addEventListener('touchstart', function(event){
                                      this.id = "hover";
                                      }, false);
            links[i].addEventListener('touchend', function(){
                                      this.id = "";
                                      }, false);
        }
    }
    
    //分享按钮
    var wrappers = document.getElementsByClassName('share_wrapper');
    if(wrappers && wrappers.length){
        for(var i = 0; i < wrappers.length; i++){
            var wrapper = wrappers[i];
            var buttons = wrapper.getElementsByClassName('share_button');
            if (buttons && buttons.length) {
                for (var j = 0; j < buttons.length; j++) {
                    if (buttons[j].getAttribute('enable') == "no") {
                        buttons[j].style.opacity = 0.3;
                        continue;
                    }
                    buttons[j].addEventListener('click', function(event){
                                                shareButtonDidClick(this);
                                                }, false);
                    buttons[j].addEventListener('touchstart', function(event){
                                                this.id = "hover";
                                                }, false);
                    buttons[j].addEventListener('touchend', function(){
                                                this.id = "";
                                                }, false);
                }
            }
        }
    }

    //普通投票按钮
    var normalVotes = document.getElementsByClassName("normalVote");
    if(normalVotes && normalVotes.length){
        for(var i = 0; i < normalVotes.length; i++){
            var vote = normalVotes[i];
            var selections = vote.getElementsByClassName("selection");
            if (selections && selections.length) {
                for (var j = 0; j < selections.length; j++) {
                    selections[j].addEventListener('click',function(event){
                        normalVoteSelectionDidClick(this);
                    }, false);
                };
            };
            var submits = vote.getElementsByClassName("submit");
            if (submits && submits.length) {
                submits[0].addEventListener('click',function(event){
                    normalVotesMultipleSubmit(this);
                }, false);
            };
        }
    }

    //PK台按钮
    var pkbuttons = document.getElementsByClassName('pkbutton');
    if(pkbuttons && pkbuttons.length){
        for(var i = 0; i < pkbuttons.length; i++){
            pkbuttons[i].addEventListener('click', function(event){
                                            pkVoteButtonDidClick(this);
                                            }, false);            
        }
    }
    
    //彩票投注按钮
    var lottery = document.getElementById("lottery_section");
    if (lottery){
        var selections = lottery.getElementsByClassName("item");
        for (var i = 0; i < selections.length; i++) {
            //不能投注的跳过
            if(selections[i].className.indexOf("canNotBetItem")>0)continue;
            selections[i].addEventListener('click',function(event){
                lotterySelectionDidClick(this);
            }, false);
        };
        var submit = lottery.getElementsByClassName("submit");
        for (var i = 0; i < submit.length; i++) {
            submit[i].addEventListener('click',function(event){
                lotterySubmitDidClick(this);
            }, false);
        };
    }
    setTimeout(function(){location.href = "show://" + document.body.scrollHeight;},100);
}

function noFirstPageAD(element){
    //热门跟贴可能会导致广告模块不出现第一屏的计算有偏差，因此此方法在跟贴后有也会调用
    if(!element){//没有element时查询一个
        var plugins = document.getElementsByClassName('ad_wrapper');
        if(!plugins || !plugins.length){
            return;
        }
        element = plugins[0];
    }
    
    element.style.marginTop = "0px";
    var y = 0;
    var i = element;
    while( i != null ) {
        y += i.offsetTop + i.clientTop;
        i = i.offsetParent;
    }
    var screenHeight = window.innerHeight - 46;
    //46是工具栏的高度的一倍尺寸，此处46不够严谨，这里HTML是有伸缩的

    if(y>0 && y<screenHeight){
        //添加顶部偏移，就出了屏幕了
        element.style.marginTop = (screenHeight-y)+"px";
    }
}

function reshow(){
    location.href = "reshow://" + document.body.scrollHeight;
}

//此处使用类jquery的方式，避免iOS8上和Youku的js混合后onload不被调用的问题
document.addEventListener( "DOMContentLoaded", onLoad, false );
// A fallback to window.onload, that will always work
//window.addEventListener('load', onLoad, false);

/*
 栏目推荐相关
 */

function removeSubsButton(pluginbox){
    var plugin = pluginbox.firstChild;
    var subbutton = plugin.nextSibling;
    //去掉订阅按钮
    pluginbox.removeChild(subbutton);
    //添加箭头
    plugin.removeAttribute('short');
    var arrows = plugin.getElementsByClassName("arrow");
    if (!arrows || arrows.length==0){
        var arrow = document.createElement('div');
        arrow.className = 'arrow';
        plugin.appendChild(arrow);
    }
}

function addSubsButtonWithEname(ename,text){
    var pluginbox = document.getElementById(ename);
    //去掉箭头
    var plugin = pluginbox.firstChild;
    plugin.setAttribute("short","true");
    var arrows = plugin.getElementsByClassName("arrow");
    if (arrows && arrows.length) {plugin.removeChild(arrows[0])};
    
    //添加订阅按钮
    subbutton = document.createElement('div');
    subbutton.className = "plugin no_tc";
    subbutton.id = "subbutton";
    subbutton.setAttribute("subs","true");
    subbutton.setAttribute("url","topic///sub///"+ename);
    subbutton.innerText = "＋" + text;
    pluginbox.appendChild(subbutton);
    addEventListenerToSubButton(subbutton);
}

function removeSubsButtonWithEname(ename){
    var pluginbox = document.getElementById(ename);
    removeSubsButton(pluginbox);
}

function addEventListenerToSubButton(subbutton){
    subbutton.addEventListener('touchstart', function(event){
                                    this.id = "hover";
                                }, false);
    subbutton.addEventListener('touchend', function(){
                                    this.id = "";
                                }, false);
    subbutton.addEventListener('click', function(event){
                                    location.href = "plugin:///" + this.getAttribute("url");
//                                    removeSubsButton(this.parentElement);
                                }, false);
}

/*
热门跟贴相关
*/
function addCommentSectionHeader()
{
    var headerHTML = "<div id='comment_section' class='section' aria-hidden='true'><div class='section_header'>热门跟贴</div><ul class='section_body'><a id='comment_list' href='comment://' class='no_tc'></a><li><a class='comment_entry no_tc' href='comment://'><div class='more_comment'>查看更多跟贴</div></a></li></ul><div class='section_footer'></div></div>";

    document.getElementById('comments_container').innerHTML = headerHTML;
}

function buildFloors(floors)
{
    var first = true;
    for (var i = 0,len = floors.length; i < len; i++) {
        var f = floors[i];
        var icon    = f["icon"];
        var name    = f["name"];
        var subname = f["subname"];
        var vote    = f["vote"];
        var body    = f["body"];
        var bigv    = f["bigv"];
        var mars    = f["mars"];
        var vip     = f["vip"];

        buildSingleFloor(icon,mars,name,subname,vote,body,bigv,first,vip);
        first = false;
    };
    noFirstPageAD();
}

function buildSingleFloor(usericon,mars,username,subname,vote,body,bigv,first,vip)
{
    var floor = document.createElement('li');
    if (first == true) {
        floor.className = 'first';
    };

    //头像、用户名、顶数
    var titleDiv = document.createElement("div");
    titleDiv.className = "floor_title";

    var voteSpan = "<span>" + vote + "</span>";
    
    var vipIcon = "";
    var vipTag = "";
    var bigvTag = "";
    //优先vip橙名，之后再红名
    if (vip == true) {
        vipIcon = "<vip></vip>";
        vipTag = "vip='true'";
    } else if (bigv == true) {
        bigvTag = "bigv='true'";
    }
    
    var iconImg = "<div class='floor_userimage' mars='" + mars + "'>" +  vipIcon + "</div>";
    if (usericon.length > 1 && mars=="false") {
        iconImg = "<div class='floor_userimage'><img src='" + usericon + "' onerror='clearImage(this)'></img>" +  vipIcon + "</div>";
    };
  
    titleDiv.innerHTML = voteSpan + iconImg + "<div class='floor_username' " + bigvTag + vipTag + ">" + username + "</div> <div class='floor_subname'>" + subname + "</div>";
    
    /*
     热门跟贴右上角暂时不要手指 by刘天放 2014.5.15
    //手指
    var upImg = document.createElement('div');
    upImg.className = 'floor_up';
    titleDiv.appendChild(upImg);
     */

    //正文
    var bodyDiv = document.createElement('div');
    bodyDiv.className = 'floor_body';
    bodyDiv.innerHTML = body;

    //拼凑好平房并加到列表上
    floor.appendChild(titleDiv);
    floor.appendChild(bodyDiv);
    var list = document.getElementById('comment_list');
    list.appendChild(floor);
}

function clearImage(element)
{
    element.style.display = "none";
}

/*
 share
 */
function shareButtonDidClick(element){
    var platform = element.getAttribute("platform");
    var href = "share://" + platform;
    location.href = href;
}

/*
 Normal Vote
 */
function normalVoteSelectionDidClick(element){
    var vote = element.parentElement;
    if (vote.getAttribute("disable") == "true") {return;};

    var isMultiple = vote.getAttribute("multiple")!=null;
    var button = element.getElementsByClassName("button")[0];
    if (isMultiple) {

        if (button.getAttribute("selected")!=null) {
            button.removeAttribute("selected")
        }else{
            button.setAttribute("selected","true");
        }

    }else{

        vote.setAttribute("disable","true");
        button.setAttribute("selected","true");
        normalVoteShowAllResults(vote);
    }
}

function normalVotesMultipleSubmit(element){
    var vote = element.parentElement;
    if (vote.getAttribute("disable") == "true") {return;};

    //检查选项是否已经有选择
    var canVote = false;
    var selections = vote.getElementsByClassName("selection");
    if (selections && selections.length) {
        for (var i = 0; i < selections.length; i++) {
            var s = selections[i];
            var button = s.getElementsByClassName("button")[0];
            if (button.getAttribute("selected") == "true") {
                canVote =true;
                break;
            }
        }
    }
    if (!canVote)return;
    
    normalVoteShowAllResults(vote);
    vote.removeChild(element);
}

function normalVoteShowAllResults(vote){
    var selections = vote.getElementsByClassName("selection");
    var votedItemIds = "";
    if (selections && selections.length) {
        for (var i = 0; i < selections.length; i++) {
            var s = selections[i]
            s.setAttribute("showResult","true");
            //隐藏按钮
            var button = s.getElementsByClassName("button")[0];
            button.style.display = "none";
            if (button.getAttribute("selected") == "true") {
                votedItemIds += (s.getAttribute("id") + ",");
            }
            //选项文本样式
            var name = s.getElementsByClassName("name")[0];
            name.setAttribute("voted","true");
            
            //显示结果
            var bar = s.getElementsByClassName("bar")[0];
            var num = s.getElementsByClassName("num")[0];
            bar.style.display = "block";
            num.style.display = "block";
            var percent = num.getAttribute("percent");
            var width = 220 * percent + "px";
            normalVoteShowResultBar(bar,width);
        }
    }

    //Vote Request
    var voteid = vote.getAttribute("id");
    location.href = "vote:///" + voteid + "///" + votedItemIds;
}

function normalVoteShowResultBar(bar,width){
    setTimeout(function(){
        bar.style.width = width;
    },0);
}

/*
 PK Vote
 */
function pkVoteButtonDidClick(element){
    var voted = element.getAttribute("voted");
    if (voted) {return;};

    var voteid = element.parentElement.parentElement.getAttribute("id");
    var index = element.getAttribute("index");
    var itemid = element.getAttribute("itemid");

    var href = "pkvote:///" + voteid + "///" + itemid + "///" + index;
    location.href = href;
}

function pkVoteDidFinish(voteId,itemIndex){
    var votes = document.getElementsByClassName("pkvote");
    var pk;
    for(var i = 0; i < votes.length; i++){
        var v = votes[i];
        var vid = v.getAttribute("id");
        if (vid == voteId) {
            pk = v;
            break;
        };
    }
    if (!pk) {return;};

    var buttons = pk.getElementsByClassName("pkbutton");
    for (var i = 0; i < buttons.length; i++) {
        var b = buttons[i];
        //按钮禁止点击
        b.setAttribute("voted","true");

        //未选的那一个颜色更改
        if((b.getAttribute("red")  && itemIndex == 1) ||
           (b.getAttribute("blue") && itemIndex == 0)){
            b.setAttribute("disable","true");
        }
    };

    //提取出投票选项的内容，准备做变更
    var nums = pk.getElementsByClassName("pknum");
    var bars = pk.getElementsByClassName("pkbar");
    var redbar,bluebar,rednum,bluenum;

    for (var i = 0; i < nums.length; i++) {
        var num = nums[i];
        if (num.getAttribute("red")) {rednum = num};
        if (num.getAttribute("blue")){bluenum = num};
    };
    for (var i = 0; i < bars.length; i++) {
        var bar = bars[i];
        if (bar.getAttribute("red")) {redbar = bar};
        if (bar.getAttribute("blue")){bluebar = bar};
    };

    //选择的那一项数字+1
    if (itemIndex == 0) {
        var n = rednum.innerText;
        rednum.innerText = ++n;
    };
    if (itemIndex == 1) {
        var n = bluenum.innerText;
        bluenum.innerText = ++n;
    };

    //重新算两个颜色条的宽度比例
    var totalNum = parseInt(rednum.innerText) + parseInt(bluenum.innerText);
    var redPercent = Math.max(100.0*rednum.innerText/totalNum , 10);
    var bluePercent = 100.0 - redPercent - 1; //这里-1为了中间的缝隙

    redbar.style.width  = redPercent.toFixed(0) + "%";
    bluebar.style.width = bluePercent.toFixed(0) + "%";
}

function updateRateNumber(upCount,downCount,upButton,downButton){
    if(!upButton){
        upButton = document.getElementsByClassName("up_up")[0];
    }
    if(!downButton){
        downButton = document.getElementsByClassName("up_down")[0];
    }
    //看看upButtontext是不是'兴趣'
    var isReader = upButton.lastChild.innerText.indexOf("兴趣") > 0;
    var upText = isReader?"感兴趣":"顶";
    var downText = isReader?"不感兴趣":"踩";

    upButton.lastChild.innerText = formatCount(upCount) + upText;
    if(isReader){
        downButton.lastChild.innerText = downText;
    }else{
        downButton.lastChild.innerText = formatCount(downCount) + downText;
    }
}

function formatCount(count){
    if (count<=0)return "";
    if(count<=99999){
        return count + "人";
    }
    return parseInt(count/10000)+"万人";
}

function parseRateCount(text){
    index = text.indexOf("人");
    if(index>0){
        indexW = text.indexOf("万");
        if(indexW>0){
            return parseInt(text.substring(0,indexW))*10000+10;
        }else{
            return parseInt(text.substring(0,index));
        }
    }else{
        return 0;
    }
}

function rateButtonClicked(element){
    //如果这个按钮已经是选中状态了就不能点了
    if (element.getAttribute("selected") == 'true') return;

    var actionLink;
    var index = parseInt(element.getAttribute("index"));
    var upButton,downButton;
    var upTimes,downTimes;

    if (index == 0){
        //“顶”操作
        upButton = element;
        downButton = element.nextSibling;
        upTimes = parseRateCount(upButton.lastChild.innerText);
        downTimes = parseRateCount(downButton.lastChild.innerText);
        
        //更新“顶”按钮数字和状态
        upTimes++;
        upButton.setAttribute("selected","true");

        //如果“踩”是选中的，也需要-1
        if (downButton.getAttribute("selected") == "true") {
            downTimes--;
            downButton.removeAttribute("selected");
        };
        actionLink = "rate://up";

    }else{
        //"踩"操作
        upButton = element.previousSibling;
        downButton = element;
        upTimes = parseRateCount(upButton.lastChild.innerText);
        downTimes = parseRateCount(downButton.lastChild.innerText);
        //更新“踩”按钮数字和状态
        downTimes++;
        downButton.setAttribute("selected","true");

        //如果“顶”是选中的，也需要-1
        if (upButton.getAttribute("selected") == "true") {
            upTimes--;
            upButton.removeAttribute("selected");
        };

        actionLink = "rate://down";
    }
    updateRateNumber(upTimes,downTimes,upButton,downButton);
    location.href = actionLink;
}

/*
 Lottery
*/
function lotterySelectionDidClick(element){
    var selected = element.getAttribute("selected");
    if (selected == "true") {
        element.removeAttribute("selected");
    }else{
        element.setAttribute("selected","true");
    }
}

function lotterySubmitDidClick(element){
    //准备所有需要的节点
    var selections = element.previousSibling;
    var lottery    = selections.parentElement.parentElement; 
    var leftItem   = selections.getElementsByClassName("leftItem")[0];
    var middleItem = selections.getElementsByClassName("middleItem")[0];
    var rightItem  = selections.getElementsByClassName("rightItem")[0];

    var leftCode   = leftItem.getAttribute("code");
    var middleCode = middleItem.getAttribute("code");
    var rightCode  = rightItem.getAttribute("code");
    
    //统计都选了哪些选项
    var items = new Array();
    if (leftItem && leftItem.getAttribute("selected")=="true") {
        items.push(leftCode);
    };
    if (middleItem && middleItem.getAttribute("selected")=="true") {
        items.push(middleCode);
    };
    if (rightItem && rightItem.getAttribute("selected")=="true") {
        items.push(rightCode);
    };
    var selectionsString = items.join(".");

    //拼出完成URL
    var baseUrl     = lottery.getAttribute("url");
    var matchCode   = lottery.getAttribute("matchCode");
    var commitUrl   = baseUrl + "?gameStr=" + matchCode + ":" + selectionsString + "&from=newswz";

    var toClient = "lottery://submit/"+commitUrl;
    location.href = toClient;
}

/*
 * 本地宝 js
 */

/**
 * 团购点击立即购买
 */
function goodsGetDidClick(protocolUrl){
    location.href = protocolUrl;
}

function goodChangeTitle(titleStr,goodId){
    var element = document.getElementById(goodId);
    element.className = "goods_saleout";
    element.onclick = "";
    var elementSpan = document.getElementById("buyButtonTitle");
    elementSpan.className = "goods_saleout span";
    elementSpan.innerText = titleStr;
}

function setElementHidden(element){
    element.style.visibility="hidden";
}


function setDefaultHidden(elementID){
    var element = document.getElementById(elementID);
    element.style.visibility="hidden";
}