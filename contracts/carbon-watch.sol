// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarbonWatch {

    // Struct to store household metrics
    struct HouseholdMetric {
        uint256 electricityUsage;  // Electricity usage in kWh
        uint256 waterUsage;        // Water usage in liters
        uint256 gasUsage;          // Natural gas usage in cubic meters
        uint256 fuelUsage;         // Fuel usage in liters (for heating or cooking)
        uint256 wasteGeneration;   // Waste generated in kg
        uint256 vehicleDistance;   // Vehicle distance driven in miles
        uint256 carbonEmission;    // Total calculated carbon emission (in kg of CO2)
        uint256 timestamp;         // Time of the logged data
    }

    // Mapping from user address to their household metrics
    mapping(address => HouseholdMetric[]) public metrics;

    // Event to emit when a new metric is logged
    event MetricLogged(
        address indexed user, 
        uint256 electricityUsage, 
        uint256 waterUsage, 
        uint256 gasUsage, 
        uint256 fuelUsage, 
        uint256 wasteGeneration, 
        uint256 vehicleDistance, 
        uint256 carbonEmission, 
        uint256 timestamp
    );

    // Function to log all household metrics and calculate carbon emission
    function logMetrics(
        uint256 _electricityUsage,  // kWh
        uint256 _waterUsage,        // Liters
        uint256 _gasUsage,          // m³
        uint256 _fuelUsage,         // Liters
        uint256 _wasteGeneration,   // kg
        uint256 _vehicleDistance    // Miles
    ) external {
        // Calculate individual carbon emissions
        uint256 electricityEmission = _electricityUsage * 233 / 1000; // 1 kWh = 0.233 kg CO2
        uint256 waterEmission = _waterUsage * 15 / 10000;             // 1 liter = 0.0015 kg CO2
        uint256 gasEmission = _gasUsage * 189 / 100;                  // 1 m³ = 1.89 kg CO2
        uint256 fuelEmission = _fuelUsage * 252 / 100;                // 1 liter = 2.52 kg CO2
        uint256 wasteEmission = _wasteGeneration * 500 / 1000;        // 1 kg of waste (general assumption) = 0.5 kg CO2
        uint256 vehicleEmission = _vehicleDistance * 404 / 1000;      // 1 mile driven (average car) = 0.404 kg CO2

        // Total carbon emission
        uint256 totalCarbonEmission = electricityEmission 
                                    + waterEmission 
                                    + gasEmission 
                                    + fuelEmission 
                                    + wasteEmission 
                                    + vehicleEmission;

        // Store the metrics for the caller (user)
        metrics[msg.sender].push(HouseholdMetric({
            electricityUsage: _electricityUsage,
            waterUsage: _waterUsage,
            gasUsage: _gasUsage,
            fuelUsage: _fuelUsage,
            wasteGeneration: _wasteGeneration,
            vehicleDistance: _vehicleDistance,
            carbonEmission: totalCarbonEmission,
            timestamp: block.timestamp
        }));

        // Emit the event
        emit MetricLogged(
            msg.sender, 
            _electricityUsage, 
            _waterUsage, 
            _gasUsage, 
            _fuelUsage, 
            _wasteGeneration, 
            _vehicleDistance, 
            totalCarbonEmission, 
            block.timestamp
        );
    }

    // Function to retrieve the number of metrics logged by a user
    function getMetricCount(address _user) external view returns (uint256) {
        return metrics[_user].length;
    }

    // Function to retrieve a specific metric by index
    function getMetric(address _user, uint256 _index) external view returns (HouseholdMetric memory) {
        require(_index < metrics[_user].length, "Invalid index");
        return metrics[_user][_index];
    }
}