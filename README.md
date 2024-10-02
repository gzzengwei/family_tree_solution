# Family Tree

## Summary

Family Tree is a Ruby application that allows you to build and query family relationships. It provides functionality to add children to the family tree and retrieve various relationships between family members.

details see [requirements](requirements.md)

## Project Setup

1. Clone the repository:

2. Install dependencies:
   ```
   bundle install
   ```

3. Run the setup script:
   ```
   bin/setup
   ```

## Project Structure

- `lib/family_tree/`: Contains the core classes of the application
  - `app.rb`: Main application logic
  - `build_tree.rb`: Builds the family tree from JSON data
  - `get_relationship.rb`: Handles relationship queries
  - `parser.rb`: Parses the JSON input file
  - `person.rb`: Represents a person in the family tree
- `bin/family_tree`: Entry point for the command-line application
- `spec/`: Contains all the test files

### Notes:

Default data file and input files are in `spec/data` folder

## Main Features

- Build a family tree from JSON data
- Add children to existing family members(on Mother's side only)
- Query relationships between family members

## Command Examples

To run the Family Tree application, use the following command:

```
bin/family_tree input_file.txt [tree_data.json]
```


Where:
- `input_file.txt` is a file containing commands to add children or get relationships
- `tree_data.json` (optional) is a JSON file containing the initial family tree data, example:

```
bin/family_tree spec/data/input.txt spec/fixtures/valid_family_tree.json
```

Example input file (`input_file.txt`):
```
ADD_CHILD Flora Minerva Female
GET_RELATIONSHIP Remus Maternal-Aunt
GET_RELATIONSHIP Minerva Siblings
```

### JSON Format for Initial Family Tree Data

The `tree_data.json` file should follow this structure:

```json
{
  "name": "King Arthur",
  "gender": "Male",
  "partner": {
    "name": "Queen Margret",
    "gender": "Female"
  },
  "children": [
    {
      "name": "Bill",
      "gender": "Male",
      "partner": {
        "name": "Flora",
        "gender": "Female"
      },
      "children": [
        {
          "name": "Victoire",
          "gender": "Female"
        }
      ]
    }
  ]
}
```

### Available Relationship Types

The application can query the following relationship types:

- Paternal-Uncle
- Maternal-Uncle
- Paternal-Aunt
- Maternal-Aunt
- Sister-In-Law
- Brother-In-Law
- Son
- Daughter
- Siblings

## Tests

To run the test suite, use the following command:

```
bundle exec rspec
```

This will run all the tests in the `spec` directory.

## Linter

This project uses StandardRB for linting. To run the linter, use:

```
bundle exec standardrb
```

To automatically fix linting issues:

```
bundle exec standardrb --fix
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/your-username/family-tree.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
