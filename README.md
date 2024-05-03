# Demo Stone Deeplink

Usei o compone feito pelo https://github.com/CarlosHe/stone-deeplink e fiz alterações para receber pix e imprimir.

A Sua POS da Stone deve estar na Versão 7.4.5 ou na ultima versao Piloto 7.7.0 para imprimir.

A Delphi (Firemonkey) demo project for integration with Stone's card machine

## ⚙️ Video Tutorial do componente e instalação
https://vimeo.com/942465797?share=copy

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

 
