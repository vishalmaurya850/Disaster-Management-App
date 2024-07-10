// contracts/DisasterManagement.sol
pragma solidity ^0.8.0;

contract DisasterManagement {
    struct Report {
        address reporter;
        string disasterType;
        string location;
        bool helpRequested;
    }

    mapping(uint => Report) public reports;
    uint public reportCount;

    event NewReport(uint reportId, address reporter, string disasterType, string location);
    event HelpRequested(uint reportId, address reporter);

    function reportDisaster(string memory _disasterType, string memory _location) public {
        reportCount++;
        reports[reportCount] = Report(msg.sender, _disasterType, _location, false);
        emit NewReport(reportCount, msg.sender, _disasterType, _location);
    }

    function requestHelp(uint _reportId) public {
        require(_reportId > 0 && _reportId <= reportCount, "Invalid report ID");
        Report storage report = reports[_reportId];
        require(report.reporter == msg.sender, "Only the reporter can request help");
        require(!report.helpRequested, "Help already requested");
        report.helpRequested = true;
        emit HelpRequested(_reportId, msg.sender);
    }
}
