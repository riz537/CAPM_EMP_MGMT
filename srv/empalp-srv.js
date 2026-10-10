import cds from '@sap/cds'

export class EmpalpService extends cds.ApplicationService { init() {

  const { Employees } = cds.entities('EmpalpService')

  this.before (['CREATE', 'UPDATE'], Employees, async (req) => {
    console.log('Before CREATE/UPDATE Employees', req.data)
  })
  this.after ('READ', Employees, async (employees, req) => {
    console.log('After READ Employees', employees)
  })


  return super.init()
}}
