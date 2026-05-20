import { ShortenUrl } from "./application/use-cases/shorten-url";
import { DynamoUrlRepository } from "./infrastructure/database/dynamodb-url-repository";

export const handler = async (event: any) => {
  try {
    const body = JSON.parse(event.body);
    const repository: DynamoUrlRepository = new DynamoUrlRepository();
    const useCase: ShortenUrl = new ShortenUrl(repository);
    const result = await useCase.execute(body.url);

    return {
      statusCode: 200,
      body: JSON.stringify(result),
    };
  } catch (error: any) {
    return {
      statusCode: 400,
      body: JSON.stringify({
        error: error.message,
      }),
    };
  }
};
