# Auto Open API HTML Generation
This action will create `html` files based on `Open API` yaml specification documents. All `yaml` documents in the `schemas/` directory will be processed. The `html` documents will generated in the `docs/` directory. 

Where a release is done the generated `html` documents will have the version number appended to the document name i.e. `doc.v1.0.0.html`.

## Inputs

### `user-name`
**Required** The user's name to be used for git related actions.

### `user-token`
**Required** The user's password or token to be used for git related actions.

### `user-email`
**Required** The user's email to be used for git related actions.

### `branch`
**Required** The branch where the generated documentation should be pushed.

## Output Parameters 

## Output

### `generated-doc-url`
The relative path to the newly generated documents

## Usage
Here's an example of creating a workflow using the action `generate-doc`. After a push the `html` documents will be generated based on the `open-api` yaml documents in the `schemas/` directory.

```yaml
name: Test
on: [push]
jobs:
  test:
    name: Test
    runs-on: ubuntu-latest
    steps:
      - name: Get the sources
        uses: actions/checkout@v2
      - name: Generate open api specifications
        id: generate-doc
        uses: ./
        with:
          user-name: ${{ secrets.BOT_USERNAME}}
          user-token: ${{ secrets.BOT_PASSWORD}}
          user-email: ${{ secrets.BOT_EMAIL}}
      - name: Print the URL for generate documentation
        if: steps.generate-doc.outputs.generated-doc-url != ''
        run: echo ${{ steps.generate-doc.outputs.generated-doc-url}}
```
