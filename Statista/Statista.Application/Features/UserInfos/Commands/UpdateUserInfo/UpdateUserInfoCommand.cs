using MediatR;
using Statista.Application.UserInfos.Dto;

namespace Statista.Application.Features.UserInfos.Commands.UpdateUserInfo;

public record UpdateUserInfoCommand(Guid Id, bool? IsMan, DateTime? Birthday) : IRequest<UserInfoResponse>;
