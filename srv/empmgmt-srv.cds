using { b83empmgmt.db as db } from '../db/Schema';

service EmpmgmtService {
    @odata.draft.enabled
    entity Employees as projection on db.Employees actions{
        action promoteEmployee(newDesignation : String) returns String;
        action makePermanent(status : String) returns String;
        function getAnnualBonus() returns Decimal(15,2);
    };
    entity Certifications as projection on db.Certifications;
    entity Docs as projection on db.Docs;
    action giveHike(hike : Integer) returns String;
    function getTopRatedEmployees() returns array of Employees;

}