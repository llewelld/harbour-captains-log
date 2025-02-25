/*
 * This file is part of Captain's Log.
 * SPDX-FileCopyrightText: 2020-2023 Mirian Margiani
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.6
import Sailfish.Silica 1.0
import SortFilterProxyModel 0.2
import "../components"

Page {
    id: page
    allowedOrientations: Orientation.All

    property alias queries: filteredModel.queries

    SearchModel {
        id: filteredModel
    }

    DiaryListView {
        anchors.fill: parent
        model: filteredModel

        header: PageHeader {
            title: qsTr("Search")
            description: qsTr("%n result(s)", "search results", filteredModel.count)
        }

        ViewPlaceholder {
            enabled: filteredModel.count === 0
            text: qsTr("No entries found")
            hintText: qsTr("Swipe back to change search criteria")
        }
    }
}
