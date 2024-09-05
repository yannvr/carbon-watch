const CarbonWatch = artifacts.require("CarbonWatch");

contract("CarbonWatch", accounts => {
    let carbonWatchInstance;

    before(async () => {
        carbonWatchInstance = await CarbonWatch.deployed();
    });

    it("should log metrics and calculate carbon emissions correctly", async () => {
        const electricityUsage = 1000; // kWh
        const waterUsage = 5000;       // Liters
        const gasUsage = 100;          // m³
        const fuelUsage = 50;          // Liters
        const wasteGeneration = 20;    // kg
        const vehicleDistance = 100;   // Miles

        const tx = await carbonWatchInstance.logMetrics(
            electricityUsage,
            waterUsage,
            gasUsage,
            fuelUsage,
            wasteGeneration,
            vehicleDistance,
            { from: accounts[0] }
        );

        // Check if the event was emitted
        assert.equal(tx.logs[0].event, "MetricLogged", "MetricLogged event should be emitted");

        // Check if the metrics are stored correctly
        const metrics = await carbonWatchInstance.metrics(accounts[0], 0);
        assert.equal(metrics.electricityUsage.toNumber(), electricityUsage, "Electricity usage should match");
        assert.equal(metrics.waterUsage.toNumber(), waterUsage, "Water usage should match");
        assert.equal(metrics.gasUsage.toNumber(), gasUsage, "Gas usage should match");
        assert.equal(metrics.fuelUsage.toNumber(), fuelUsage, "Fuel usage should match");
        assert.equal(metrics.wasteGeneration.toNumber(), wasteGeneration, "Waste generation should match");
        assert.equal(metrics.vehicleDistance.toNumber(), vehicleDistance, "Vehicle distance should match");

        // Calculate expected carbon emission
        const expectedCarbonEmission = 
            electricityUsage * 233 / 1000 +
            waterUsage * 15 / 10000 +
            gasUsage * 189 / 100 +
            fuelUsage * 252 / 100 +
            wasteGeneration * 500 / 1000 +
            vehicleDistance * 404 / 1000;

        assert.equal(metrics.carbonEmission.toNumber(), expectedCarbonEmission, "Carbon emission should match");
    });
});