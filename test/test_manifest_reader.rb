# frozen_string_literal: true

require "test_helper"

class TestManifestReader < Minitest::Test
  def test_should_find_all_tag_names
    manifest_contents = File.read(fixture_path("shoelace-manifest.json"))

    tag_names = PhlexCustomElementGenerator::ManifestReader.new(manifest: manifest_contents).list_tag_names

    actual_tag_names = [
      "sl-alert",
      "sl-animated-image",
      "sl-animation",
      "sl-badge",
      "sl-avatar",
      "sl-breadcrumb",
      "sl-breadcrumb-item",
      "sl-button",
      "sl-button-group",
      "sl-card",
      "sl-carousel",
      "sl-carousel-item",
      "sl-checkbox",
      "sl-color-picker",
      "sl-copy-button",
      "sl-details",
      "sl-dialog",
      "sl-divider",
      "sl-drawer",
      "sl-dropdown",
      "sl-format-bytes",
      "sl-format-date",
      "sl-format-number",
      "sl-icon",
      "sl-icon-button",
      "sl-image-comparer",
      "sl-include",
      "sl-input",
      "sl-menu",
      "sl-mutation-observer",
      "sl-option",
      "sl-menu-item",
      "sl-menu-label",
      "sl-popup",
      "sl-progress-ring",
      "sl-progress-bar",
      "sl-qr-code",
      "sl-radio",
      "sl-radio-button",
      "sl-radio-group",
      "sl-range",
      "sl-relative-time",
      "sl-rating",
      "sl-resize-observer",
      "sl-select",
      "sl-skeleton",
      "sl-spinner",
      "sl-split-panel",
      "sl-switch",
      "sl-tab",
      "sl-tab-group",
      "sl-tag",
      "sl-tab-panel",
      "sl-textarea",
      "sl-tooltip",
      "sl-tree",
      "sl-tree-item",
      "sl-visually-hidden"
    ]

    assert_equal(tag_names, actual_tag_names)
  end
end
