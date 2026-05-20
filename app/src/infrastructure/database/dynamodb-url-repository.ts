import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, PutCommand } from "@aws-sdk/lib-dynamodb";
import { UrlRepository } from "../../ports/url-repository";
import { ShortUrl } from "../../domain/entities/short-url";

export class DynamoUrlRepository implements UrlRepository {
  private readonly client = DynamoDBDocumentClient.from(
    new DynamoDBClient({}),
    {
      marshallOptions: {
        convertClassInstanceToMap: true,
        removeUndefinedValues: true,
      },
    },
  );

  async save(url: ShortUrl) {
    await this.client.send(
      new PutCommand({
        TableName: process.env.DYNAMODB_TABLE,

        Item: {
          shortCode: url.shortCode,
          originalUrl: url.originalUrl,
        },
      }),
    );
  }
}
