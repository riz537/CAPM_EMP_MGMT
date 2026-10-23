using {b83empmgmt.db as db} from '../db/Schema';


service EmpovpService {
    @readonly
    entity Employees as projection on db.Employees;

}