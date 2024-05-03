/-  index
/+  default-agent, dbug, agentio, mast
/=  mainindex  /app/sail/index
/=  stylesheet  /app/sail/stylesheet
|%
+$  state-0  [%0 example-state:index]
+$  versioned-state  $%(state-0)
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
    io    ~(. agentio bowl)
    :: a list of cells of url paths to gates (your sail components), are required for rig:mast.
    :: see the example sail component for more information.
    :: these define all of the different pages for your app.
    routes  %-  limo  :~  
        :-  /index  mainindex
      ==
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: 
++  on-init
  ^-  (quip card _this)
  :_  this
  :: binding the base url:
  [(~(arvo pass:io /bind) %e %connect `/'index' %index) ~]
++  on-save
  ^-  vase
  !>  state
++  on-load
  |=  saved-state=vase
  ^-  (quip card _this)
  `this(state !<(versioned-state saved-state))
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: 
++  on-poke
  |=  [=mark =vase]
  |^  ^-  (quip card _this)
  =^  cards  state
    ?+  mark  (on-poke:def mark vase)
      :: mast uses a combination of direct http and the channel system.
      :: pokes will be received under these two marks:
      :: %handle-http-request is for when the app is accessed via the url,
      :: %json is for the client event pokes that the mast script will send.
      %handle-http-request
        (handle-http-request !<([@ta inbound-request:eyre] vase))
    ==
  [cards this]
  ::
  ++  handle-http-request
    |=  [eyre-id=@ta req=inbound-request:eyre]
    ^-  (quip card _state)
    :: handling authentication:
    ?+  method.request.req  [(make-400:mast eyre-id) state]
      %'GET'
        :: the request url from eyre can be parsed into a path either with stab,
        :: or with parse-url:mast which handles trailing slashes and allows for all characters in @t.
        =/  url=path  (parse-url:mast url.request.req)
        :: css ought to be linked to from the head of the sail document, and can be handled like this:
        ?:  =(/index/css url)
          [(make-css-response:mast eyre-id stylesheet) state]
        ::
        :: --- rig ---
        :: rig produces new display data which is used for plank, gust, and for updating your agent's display state.
        :: note: in the rig sample, "app" here just represents whatever your root-level sail components take as their sample (see example-sail for more information).
        =/  new-display  (rig:mast routes url app)
        ::
        :: --- plank ---
        :: plank is the endpoint that the client will hit first when loading the app via the url.
        :: it serves any of the pages in your routes list according to the request url (and otherwise a default 404 page).
        :: plank inserts the library's script into your sail component to set up all of the client side functionality.
        :-  (plank:mast "index" /display-updates our.bowl eyre-id new-display)
        ::
        :: state is then set with the new display and url:
        state(display new-display, current-url url)
    ==
  --
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: 
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+  path  (on-watch:def path)
    [%http-response *]
      %-  (slog leaf+"Eyre subscribed to {(spud path)}." ~)
      `this
    [%display-updates *]
      %-  (slog leaf+"Eyre subscribed to {(spud path)}." ~)
      `this
  ==
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: 
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([%bind ~] wire)
    (on-arvo:def [wire sign-arvo])
  ?.  ?=([%eyre %bound *] sign-arvo)
    (on-arvo:def [wire sign-arvo])
  ~?  !accepted.sign-arvo
    %eyre-rejected-squad-binding
  `this
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: 
++  on-fail   on-fail:def
--