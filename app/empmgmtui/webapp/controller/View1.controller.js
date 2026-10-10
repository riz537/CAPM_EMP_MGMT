sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox"
], (Controller,MessageBox) => {
    "use strict";

    return Controller.extend("com.demo.empmgmtui.controller.View1", {
        onInit() {
        },
        // =========================================================
        // 1. BOUND ACTION: promoteEmployee(newDesignation)
        // =========================================================
        onPromoteEmployee: async function (oEvent) {
            const oContext = this.byId("oTableEmp").getSelectedItem().getBindingContext();

            const oModel = this.getView().getModel();

            const oAction = oModel.bindContext(
                "EmpmgmtService.promoteEmployee(...)",
                oContext
            );
            oAction.setParameter("newDesignation", "DEVELOPER");
            try {
                await oAction.invoke();
                let msg = oAction.getBoundContext().getObject().value;
                MessageBox.success(msg);
                 oContext.refresh();
            } catch (oError) {
                MessageBox.error(oError.message);
            } 
        },


        // =========================================================
        // 2. BOUND ACTION: makePermanent(status)
        // =========================================================
        onMakePermanent: async function (oEvent) {
            const oContext = this.byId("oTableEmp").getSelectedItem().getBindingContext();
            const oModel = this.getView().getModel();
            const oAction = oModel.bindContext(
                "EmpmgmtService.makePermanent(...)",
                oContext
            );
            oAction.setParameter("status", "PERMANENT");
            try {
                await oAction.invoke();
              let msg = oAction.getBoundContext().getObject().value;
                MessageBox.success(msg);
                oContext.refresh();
            } catch (oError) {
                MessageBox.error(oError.message);
            } 
        },


        // =========================================================
        // 3. BOUND FUNCTION: getAnnualBonus()
        // =========================================================
        onGetAnnualBonus: async function (oEvent) {
            const oContext = this.byId("oTableEmp").getSelectedItem().getBindingContext();
            const oModel = this.getView().getModel();
            const oFunction = oModel.bindContext(
                "EmpmgmtService.getAnnualBonus(...)",
                oContext
            );

            try {
               await oFunction.invoke();
              let msg = oFunction.getBoundContext().getObject().value;
                MessageBox.success("Bonus-->"+msg);
                oContext.refresh();
            } catch (oError) {
                MessageBox.error(oError.message);
            } finally {
                oFunction.destroy();
            }
        },


        // =========================================================
        // 4. UNBOUND ACTION: giveHike(hike)
        // =========================================================
        onGiveHike: async function () {
            const oModel = this.getView().getModel();

            const oAction = oModel.bindContext(
                "/EmpmgmtService.giveHike(...)"
            );
            oAction.setParameter("hike", 10);
            try {
                  await oAction.invoke();
              let msg = oAction.getBoundContext().getObject().value;
                MessageBox.success("msg-->"+msg);
                oModel.refresh();
            } catch (oError) {
                MessageBox.error(oError.message);
            } finally {
                oAction.destroy();
            }
        },


        // =========================================================
        // 5. UNBOUND FUNCTION: getTopRatedEmployees()
        // =========================================================
        onGetTopRatedEmployees: async function () {
            const oModel = this.getView().getModel();

            const oFunction = oModel.bindContext(
                "/EmpmgmtService.getTopRatedEmployees(...)"
            );

            try {
                  await oFunction.invoke();
              let msg = oFunction.getBoundContext().getObject().value;
              console.log("onGetTopRatedEmployees");
                console.log(msg);
                oModel.refresh();
            } catch (oError) {
                MessageBox.error(oError.message);
            } finally {
                oFunction.destroy();
            }
        }
    });
});