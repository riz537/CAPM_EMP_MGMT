using EmpalpService  from './empalp-srv';

annotate EmpalpService.Employees with @(
    UI.Chart              : {
        Title              : 'Designation wise Salary',
        ChartType          : #Column,
        Dimensions         : [designation],
        DynamicMeasures    : [@Analytics.AggregatedProperty#salary,@Analytics.AggregatedProperty#rating],
        MeasureAttributes  : [{
            Measure: salary,
            Role   : #Axis1
        }],
        DimensionAttributes: [{
            Dimension: designation,
            Role     : #Category
        }]
    },
    UI.PresentationVariant: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: [@UI.Chart]
    },
    UI.LineItem           : [
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

annotate EmpalpService.Employees with @(
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
annotate EmpalpService.Employees with {
    ID           @Common.Label: 'ID';
    name   @Common.Label: 'Employee name';
    designation @Common.Label: 'Designation';
    email @Common.Label: 'Email';
    rating @Common.Label: 'Rating';
};