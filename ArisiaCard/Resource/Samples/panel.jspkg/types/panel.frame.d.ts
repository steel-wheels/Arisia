interface root_buttons_load_button_ButtonIF extends ButtonIF {
}
interface root_buttons_save_button_ButtonIF extends ButtonIF {
}
interface root_buttons_quit_button_ButtonIF extends ButtonIF {
}
interface root_buttons_BoxIF extends BoxIF {
  load_button : root_buttons_load_button_ButtonIF ;
  save_button : root_buttons_save_button_ButtonIF ;
  quit_button : root_buttons_quit_button_ButtonIF ;
}
interface root_BoxIF extends BoxIF {
  buttons : root_buttons_BoxIF ;
}
