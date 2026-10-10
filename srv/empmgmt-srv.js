import cds from '@sap/cds'

const { UPDATE, SELECT,DELETE,CREATE } = cds.ql;


export class EmpmgmtService extends cds.ApplicationService {
  init() {

    const { Employees, Certifications, Docs } = cds.entities('EmpmgmtService')

    this.on('promoteEmployee', async req => {
      const employeeId = req.params[0].ID;
      const { newDesignation } = req.data;

      await UPDATE(Employees)
        .set({ designation: newDesignation })
        .where({ ID: employeeId });

      return `Employee promoted to ${newDesignation}`;
    });
    this.on('makePermanent', async req => {

      const employeeId = req.params[0].ID;
      const { status } = req.data;

      await UPDATE(Employees)
        .set({ status })
        .where({ ID: employeeId });

      return `Employee status changed to ${status}`;
    });
    this.on('getAnnualBonus', async req => {
      const employeeId = req.params[0].ID;
      const employee = await SELECT.one
        .from(Employees)
        .where({ ID: employeeId });
      const annualSalary = employee.salary;
      let bonus = 0;
      if (employee.rating >= 5) {
        bonus = annualSalary * 0.20;
      } else if (employee.rating === 4) {
        bonus = annualSalary * 0.10;
      } else if (employee.rating === 3) {
        bonus = annualSalary * 0.05;
      }
      return bonus;
    });
    this.on('giveHike', async req => {

      const { hike } = req.data;
     console.log("Inside give hike"+ hike);
      const employees = await SELECT.from(Employees);
       console.log(employees);
      for (const emp of employees) {

        const currentSalary = Number(emp.salary || 0);

        const newSalary = currentSalary + ((currentSalary * hike) / 100);

        await UPDATE(Employees)
          .set({ salary: newSalary })
          .where({ ID: emp.ID });
      }

      return `${hike}% hike given to all employees`;
    });
    this.on('getTopRatedEmployees', async req => {
      return await SELECT.from(Employees)
        .where({
          rating: { '>=': 4 }
        });
    });

    return super.init()
  }
}
