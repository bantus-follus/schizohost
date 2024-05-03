:: this is a root-level sail component, 
:: meant to be collected into a route list to be used with rig in the agent.
:: there are a few features necessary for a root-level sail component in order for it to work with mast:
:: 1) it needs to be a gate which produces manx.
:: 2) it must produce a complete document with html, head, and body tags.
:: 3) all root-level sail components need to have the same sample (the sample can be any noun).
/-  index
|=  app-state=app.example-state.index
^-  manx
;html
  ;head
    ;meta(charset "utf-8");
    :: it is strongly advised to link to any css instead of including it in a style tag.
    :: see the example agent for an example of how to serve the css for a link.
    ;link(href "/index/css", rel "stylesheet");
  ==
  ;body
      ;img@"https://schizohost.nyc3.cdn.digitaloceanspaces.com/pixelady.jpg";
      ;h1: ~bantus-follus
      ;br;
      ;a/"words": Blog (nothing here)
      ;br;
      ;a/"https://soundcloud.com/retropronoic/sets/schizo-essentials": Music 
      ;br;
      ;a/"https://twitter.com/_bantus_follus": Twitter
      ;br;
      ;br;
      ;br;
      ;br;
      ;br;
      ;br;
      ; Hosted on 
      ;a/"https://urbit.org": Urbit
  ==
==
