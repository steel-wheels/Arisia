{
  terminal: Terminal {
    main: init %{
      let strcode0 = EscapeSequences.string("Hello, world !!") ;
      self.console.print(strcode0.toString()) ;

      //let insspc0 = EscapeSequences.insertSpaces(3) ;
      //self.console.print(insspc0.toString()) ;

      let strcode1 = EscapeSequences.string("Good morning !!") ;
      self.console.print(strcode1.toString()) ;

      //let back0 = EscapeSequences.cursorBackward(10) ;
      //self.console.print(back0.toString()) ;

      //let insspc1 = EscapeSequences.insertSpaces(8) ;
      //self.console.print(insspc1.toString()) ;

      //let strcode2 = EscapeSequences.string("evening/") ;
      //self.console.print(strcode2.toString()) ;
    %}
  }
}

