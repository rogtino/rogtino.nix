{...}: {
  programs.newsboat = {
    enable = true;
    maxItems = 50;
    autoReload = true;
    urls = [
      {url = "https://www.ruanyifeng.com/blog/atom.xml";}
      {url = "https://v2ex.com/index.xml";}
      {url = "https://rsshub.app/zhihu/hotlist";}
      {url = "https://neovim.io/news.xml";}
      {url = "https://dotfyle.com/this-week-in-neovim/rss.xml";}
      {url = "https://weekly.howie6879.com/rss/rss.xml";}
      {url = "https://news.ycombinator.com/rss";}
      {url = "https://plink.anyfeeder.com/weixin/DJ00123987";}
      {url = "https://plink.anyfeeder.com/weixin/liweitan2014";}
      {url = "https://plink.anyfeeder.com/weixin/runliu-pub";}
      {url = "https://plink.anyfeeder.com/weixin/eeo-com-cn";}
    ];
    extraConfig = ''
      # externel browser
      browser "w3m %u"
      macro m set browser "mpv %u"; open-in-browser ; set browser "w3m %u"
      macro f set browser "firefox %u"; open-in-browser ; set browser "w3m %u"
      # unbind keys
      unbind-key ENTER
      unbind-key j
      unbind-key k
      unbind-key J
      unbind-key K
      unbind-key u
      # bind keys - vim style
      bind-key j down
      bind-key k up
      bind-key l open
      bind-key h quit
      bind-key d halfpagedown
      bind-key u halfpageup
      bind-key U show-urls
      color background default default
      color listnormal color255 default
      color listfocus color238 color255 standout
      color listnormal_unread color47 default
      color listfocus_unread color238 color47 standout
      color info color141 color236

      # highlights
      highlight all "---.*---" yellow
      highlight feedlist ".*(0/0))" black
      highlight article "(^Feed:|^Title:|^Date:|^Link:|^Author:)" cyan default bold
      highlight article "https?://[^ ]+" yellow default
      highlight article "\\[[0-9][0-9]*\\]" magenta default bold
      highlight article "\\[image\\ [0-9]+\\]" green default bold
      highlight article "\\[embedded flash: [0-9][0-9]*\\]" green default bold
      highlight article ":.*\\(link\\)$" cyan default
      highlight article ":.*\\(image\\)$" blue default
      highlight article ":.*\\(embedded flash\\)$" magenta default
    '';
  };
}
