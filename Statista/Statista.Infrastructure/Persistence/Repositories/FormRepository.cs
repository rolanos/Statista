
using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class FormRepository : IFormRepository
{
    private readonly PostgresDbContext _dbContext;

    public FormRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<Form?> CreateForm(Form form)
    {
        await _dbContext.AddAsync(form);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.Forms.SingleOrDefaultAsync(u => u.Id == form.Id);
    }

    public async Task<ICollection<Form>> GetAllForms(Guid SurveyId)
    {
        return await _dbContext.Forms.AsNoTracking()
                                     .Include(f => f.Survey)
                                     .Include(f => f.CreatedBy)
                                     .Where(f => f.SurveyId == SurveyId)
                                     .ToListAsync();
    }

    public async Task<Form?> GetFormBySurveyId(Guid surveyId)
    {
        return await _dbContext.Forms.AsNoTracking()
                                     .SingleOrDefaultAsync(u => u.SurveyId == surveyId);
    }


    public async Task<Form?> GetFormById(Guid id)
    {
        return await _dbContext.Forms.AsNoTracking()
                                     .SingleOrDefaultAsync(u => u.Id == id);
    }

    public async Task<Form?> DeleteById(Guid id)
    {
        var form = await _dbContext.Forms.AsNoTracking()
                                         .SingleOrDefaultAsync(u => u.Id == id);
        if (form is not null)
        {
            _dbContext.Forms.Remove(form);
            await _dbContext.SaveChangesAsync();
            return form;
        }
        return null;
    }
}