{
  timer: Timer {
    interval:    number 1
    main: init %{
      self.addHandler(function(repcnt: number): boolean {
        root.label.text = "count: " + repcnt ;
        return true ;
      }) ;
      self.start() ;
    %}
  }
  label: Label {
    text: string "Hello, World !!"
  }
  ok_button: Button {
        title: string "OK"
        pressed: event() %{
          root.timer.stop() ;
          leaveView(0) ;
        %}
  }
}

