# Demo Stone Deeplink

A Delphi (Firemonkey) demo project for integration with Stone's card machine

## ⚙️ Video Tutorial do componente e instalação
<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/942465797?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Delphi Stone DeepLink Tutorial"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>


After running, just open the project and enjoy!

## ⚙️ Configuration

According to [`documentation`](https://sdkandroid.stone.com.br/reference/configuracao-deeplink), it's necessary to define a name for the *scheme*. By default, the demo project was set to "demo_stone_deeplink", remember to change it in your real project.

### ⚡️ Changes to *AndroidManifest*:

``` xml
<intent-filter>
  ...
    <data
        android:host="pay-response"
        android:scheme="demo_stone_deeplink" />
</intent-filter>
```
``` xml
<intent-filter>
  ...
    <data
        android:host="cancel"
        android:scheme="demo_stone_deeplink" />
</intent-filter>
```
``` xml
 <intent-filter>
    ...
    <data
        android:host="print"
        android:scheme="demo_stone_deeplink" />
</intent-filter>

```
``` xml
<intent-filter>
   ...
    <data
        android:host="reprint"
        android:scheme="demo_stone_deeplink" />
</intent-filter>

```

### ⚡️ Changes to the StoneDeeplink component:

Go to *Object Inspect*, find *Scheme* property and change it according to the same name defined in *AndroidManifest*

 
