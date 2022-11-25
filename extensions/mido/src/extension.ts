import * as vscode from 'vscode';
import * as path from 'path';

// import anime from './command/anime';
interface ItemType {
	status: 'success' | 'init'
	content: string
}
type TimeType = 'day' | 'week' | 'month';
type ButtonType = 'add' | 'clear' | 'remove' | 'success';
let dayList: ItemType[] = [];
let weekList: ItemType[] = [];
let monthList: ItemType[] = [];
let gcontext: vscode.ExtensionContext;

class TreeDataProvider implements vscode.TreeDataProvider<TreeItem> {
  onDidChangeTreeData?: vscode.Event<TreeItem|null|undefined>|undefined;

  data: TreeItem[];

  constructor(timeType: TimeType, type: ButtonType, msg?: string) {
		let list = [];
		if (timeType === 'day') {
			list= dayList;
		} else if (timeType === 'week') {
			list= weekList;
		} else {
			list= monthList;
		}
		if (type === 'add') {
			msg && list.push({ status: 'init', content: msg });
			this.data = list.map((item: ItemType) => new TreeItem(item));
		} else if (type === 'clear') {
			list = [];
			this.data = [];
		} else if (type === 'remove') {
			const index = msg ? list.map((item) => item.content).indexOf(msg) : 0;
			list.splice(index, 1);
			this.data = list.map((item: ItemType) => new TreeItem(item));
		} else if (type === 'success') {
			const index = msg ? list.map((item) => item.content).indexOf(msg) : 0;
			list[index].status = 'success';
			this.data = list.map((item: ItemType) => new TreeItem(item));
		} else {
			this.data = [];
		}
		gcontext.globalState.update('day-list', dayList);
		gcontext.globalState.update('week-list', weekList);
		gcontext.globalState.update('month-list', monthList);
  }

  getTreeItem(element: TreeItem): vscode.TreeItem|Thenable<vscode.TreeItem> {
    return element;
  }

  getChildren(element?: TreeItem|undefined): vscode.ProviderResult<TreeItem[]> {
    if (element === undefined) {
      return this.data;
    }
    return element.children;
  }
}

class InitProvider implements vscode.TreeDataProvider<TreeItem> {
  onDidChangeTreeData?: vscode.Event<TreeItem|null|undefined>|undefined;

  data: TreeItem[];

  constructor(timeType: TimeType) {
		let list = [];
		if (timeType === 'day') {
			list= dayList;
		} else if (timeType === 'week') {
			list= weekList;
		} else {
			list= monthList;
		}
		this.data = list.map((item: ItemType) => new TreeItem(item));
  }

  getTreeItem(element: TreeItem): vscode.TreeItem|Thenable<vscode.TreeItem> {
    return element;
  }

  getChildren(element?: TreeItem|undefined): vscode.ProviderResult<TreeItem[]> {
    if (element === undefined) {
      return this.data;
    }
    return element.children;
  }
}

class TreeItem extends vscode.TreeItem {
  children: TreeItem[]|undefined;

  constructor(item: ItemType, children?: TreeItem[]) {
    super(
			item.content,
			children === undefined
				? vscode.TreeItemCollapsibleState.None
				: vscode.TreeItemCollapsibleState.Expanded
		);
    this.children = children;
		const svg = path.join(__filename, '..', '..', 'template', 'svg', `${item.status}.svg`);
		this.iconPath = {
			light: svg,
			dark: svg
		};
  }
}

const draw = (timeType: TimeType, type: ButtonType, msg?: string) => {
	vscode.window.registerTreeDataProvider(`${timeType}-plan`, new TreeDataProvider(timeType, type, msg));
};

const handleAdd = (timeType: TimeType) => {
	vscode.window.showInputBox(
		{
			password:false,
			ignoreFocusOut:true,
			placeHolder:'输入待办事项'
		}
	).then((msg: any) => {
		draw(timeType, 'add', msg);
	});
};

async function init() {
	dayList = gcontext.globalState.get(`day-list`) || [];
	weekList = gcontext.globalState.get(`week-list`) || [];
	monthList = gcontext.globalState.get(`month-list`) || [];
	console.log(dayList, weekList, monthList);
	vscode.window.registerTreeDataProvider(`day-plan`, new InitProvider('day'));
	vscode.window.registerTreeDataProvider(`week-plan`, new InitProvider('week'));
	vscode.window.registerTreeDataProvider(`month-plan`, new InitProvider('month'));
}

export function activate(context: vscode.ExtensionContext) {
	gcontext = context;

	init();
	
	// 新增
	const addDay = vscode.commands.registerCommand('sineava.day.add', () => {
		handleAdd('day');
	});
	const addWeek = vscode.commands.registerCommand('sineava.week.add', () => {
		handleAdd('week');
	});
	const addMonth = vscode.commands.registerCommand('sineava.month.add', () => {
		handleAdd('month');
	});

	// 移除
	const removeDay = vscode.commands.registerCommand('sineava.day.remove', (co: { label: string }) => {
		draw('day', 'remove', co.label);
	});
	const removeWeek = vscode.commands.registerCommand('sineava.week.remove', (co: { label: string }) => {
		draw('week', 'remove', co.label);
	});
	const removeMonth = vscode.commands.registerCommand('sineava.month.remove', (co: { label: string }) => {
		draw('month', 'remove', co.label);
	});

	// 完成
	const successDay = vscode.commands.registerCommand('sineava.day.success', (co: { label: string }) => {
		draw('day', 'success', co.label);
	});
	const successWeek = vscode.commands.registerCommand('sineava.week.success', (co: { label: string }) => {
		draw('week', 'success', co.label);
	});
	const successMonth = vscode.commands.registerCommand('sineava.month.success', (co: { label: string }) => {
		draw('month', 'success', co.label);
	});
	
	context.subscriptions.push(addDay);
	context.subscriptions.push(addWeek);
	context.subscriptions.push(addMonth);
	context.subscriptions.push(removeDay);
	context.subscriptions.push(removeWeek);
	context.subscriptions.push(removeMonth);
	context.subscriptions.push(successDay);
	context.subscriptions.push(successWeek);
	context.subscriptions.push(successMonth);
}

export function deactivate() {}
