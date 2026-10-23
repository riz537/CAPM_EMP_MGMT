using EmpovpService  from './empovp-srv';

annotate EmpovpService.Employees with @(
    UI.Chart   #DesignationVsSalary : {
        Title              : 'Designation Vs Salary',
        ChartType          : #Column,
        Dimensions         : [designation],
        DynamicMeasures    : [@Analytics.AggregatedProperty#salary],
        MeasureAttributes  : [{
            DynamicMeasure: @Analytics.AggregatedProperty#salary,
            Role   : #Axis1
        }],
        DimensionAttributes: [{
            Dimension: designation,
            Role     : #Category
        }]
    },
    UI.PresentationVariant #PVDesignationVsSalary: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: [@UI.Chart#DesignationVsSalary]
    },
    UI.Chart   #EmpVsRating : {
        Title              : 'Employee Vs Rating',
        ChartType          : #Column,
        Dimensions         : [name],
        DynamicMeasures    : [@Analytics.AggregatedProperty#rating],
        MeasureAttributes  : [{
            DynamicMeasure: @Analytics.AggregatedProperty#rating,
            Role   : #Axis1
        }],
        DimensionAttributes: [{
            Dimension: name,
            Role     : #Category
        }]
    },
    UI.PresentationVariant #PVEmpVsRating: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: [@UI.Chart#EmpVsRating]
    },
    UI.LineItem #TableCard : [
        {
            Value: ID,
            Label: 'Employee ID'
        },
        {
            Value: name,
            Label: 'Employee name'
        },
        {
            Value: designation,
            Label: 'Designation'
        },
        {
            Value: salary,
            Label: 'Salary'
        },
        {
            Value: rating,
            Label: 'Rating'
        }
         
    ],
    UI.SelectionFields    : [
        ID,
        name,
        designation,
        rating,
        salary

    ],
    Analytics.AggregatedProperty #salary: {
        $Type                      : 'Analytics.AggregatedPropertyType',
        AggregatableProperty       : salary,
        AggregationMethod          : 'avg',
        Name                       : 'salary',
        ![@Common.Label]           : 'Salary',
    },
    Analytics.AggregatedProperty #rating: {
        $Type                      : 'Analytics.AggregatedPropertyType',
        AggregatableProperty       :  rating,
        AggregationMethod          : 'avg',
        Name                       : 'rating',
        ![@Common.Label]           : 'Rating',
    },
)
{
    salary  @Analytics.Measure: true;
    rating @Analytics.Measure: true;
};

annotate EmpovpService.Employees with @(
    Aggregation.ApplySupported            : {
        Transformations       : [
            'aggregate',
            'groupby',
            'filter'
        ],
        GroupableProperties   : [
           designation, name
        ],
        AggregatableProperties: [
             {
                $Type: 'Aggregation.AggregatablePropertyType',
                Property: salary,
                SupportedAggregationMethods: ['Sum','Average','Min','Max']   
            },
            {
                $Type: 'Aggregation.AggregatablePropertyType',
                Property: rating,
                SupportedAggregationMethods: ['Sum','Average','Min','Max']
            }
        ]
    },
);
annotate EmpovpService.Employees with {
    ID           @Common.Label: 'ID';
    name   @Common.Label: 'Employee name';
    designation @Common.Label: 'Designation';
    email @Common.Label: 'Email';
    rating @Common.Label: 'Rating';
};