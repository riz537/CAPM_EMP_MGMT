using {b83empmgmt.db as db} from '../db/Schema';


service EmpalpService {
    @readonly
    entity Employees as projection on db.Employees;

}