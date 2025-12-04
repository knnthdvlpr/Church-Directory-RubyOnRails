// app/javascript/controllers/index.js
import { application } from "./application"

import MemberFormController from "./member_form_controller"
application.register("member-form", MemberFormController)

import DropdownController from "./dropdown_controller"
application.register("dropdown", DropdownController)

import MobileMenuController from "./mobile_menu_controller"
application.register("mobile-menu", MobileMenuController)