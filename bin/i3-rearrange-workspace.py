#!/usr/bin/env python3

import json
import subprocess
import sys


def show_error(message: str):
    print(
        "this script only works when the workspace names contain only numbers!",
        file=sys.stderr,
    )
    print(message, file=sys.stderr)


def get_workspaces():
    # Get the current workspaces from i3
    try:
        output = subprocess.check_output(["i3-msg", "-t", "get_workspaces"])
        workspaces = json.loads(output)
        return workspaces
    except subprocess.CalledProcessError as e:
        show_error(f"Error getting workspaces: {e}")
        sys.exit(1)
    except json.JSONDecodeError as e:
        show_error(f"Error parsing workspaces JSON: {e}")
        sys.exit(1)


def rename_workspace(old_name: str, new_name: str):
    # Rename a workspace using i3-msg
    try:
        cmd = f'i3-msg "rename workspace "{old_name}" to "{new_name}""'
        _ = subprocess.run(cmd, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        show_error(f"Error renaming workspace from '{old_name}' to '{new_name}': {e}")


def main():
    try:
        # Get current workspaces
        workspaces = get_workspaces()

        # Sort workspaces by their names
        workspaces.sort(key=lambda w: w["name"])

        # For each workspace, rename it to its new number
        new_number = 1
        for workspace in workspaces:
            old_name = workspace["name"]

            # Extract the current number and any additional text after it
            current_number = ""
            additional_text = ""
            for i, char in enumerate(old_name):
                if char.isdigit():
                    current_number += char
                else:
                    additional_text = old_name[i:]
                    break

            if current_number and int(current_number) != new_number:
                new_name = str(new_number) + additional_text
                rename_workspace(old_name, new_name)

            new_number += 1

    except Exception as e:
        show_error(f"Unexpected error: {str(e)}")
        sys.exit(1)


if __name__ == "__main__":
    main()
