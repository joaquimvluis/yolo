// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import CompleteTaskController from "./complete_task_controller"
application.register("complete-task", CompleteTaskController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import RefreshUsersListController from "./refresh_users_list_controller"
application.register("refresh-users-list", RefreshUsersListController)

import UpdateKpiCompletedTaskController from "./update_kpi_completed_task_controller"
application.register("update-kpi-completed-task", UpdateKpiCompletedTaskController)

import KpiController from "./kpi_controller"
application.register("kpi", KpiController)
