namespace b83empmgmt.db;

using { cuid,managed } from '@sap/cds/common';


entity Employees : cuid,managed {
    name: String(30);
    designation: String(20);
    email: String(20);
    phone: String(10);
    salary: Decimal(13,2);
    rating: Int16;
    status: String;
    dof: Date;
    image: LargeBinary @Core.MediaType:'image/jpg';
    certifications: Composition of many Certifications on certifications.emp = $self;
    docs: Composition of many Docs on docs.emp = $self;

}
entity Certifications : cuid {
     emp: Association to Employees; 
     code: String(50);
     description: String(100);
}
entity Docs : cuid {
     emp: Association to Employees; 
     fileName: String;
     fileType: String @Core.IsMediaType:true;
     fileContent: LargeBinary @Core.MediaType:fileType @Core.ContentDisposition.Filename:fileName @Core.ContentDisposition.Type:'attachment'; 
}