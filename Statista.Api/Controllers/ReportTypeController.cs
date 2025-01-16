using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features;
using Statista.Application.Features.Report.Commands.CreateReport;
using Statista.Application.Features.Report.Queries.GetReportById;
using Statista.Application.Features.Report.Queries.GetReports;
using Statista.Application.Features.Report.Queries.GetReportsByQuestionId;

namespace Statista.Api.Controllers;

[ApiController]
[Route("api/report_types")]
public class ReportTypeController : BaseController
{
}