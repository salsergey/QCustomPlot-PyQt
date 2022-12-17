/** PyQt5 binding for QCustomPlot v2.1.1
 *  
 *  Authors: Dmitry Voronin, Giuseppe Corbelli
 *  License: MIT
 *  
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPMarginGroup : public QObject
{
%TypeHeaderCode
#include <qcustomplot.h>
%End

public:
  explicit QCPMarginGroup(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPMarginGroup();
  
  // non-virtual methods:
  QList<QCPLayoutElement*> elements(QCP::MarginSide side) const;
  bool isEmpty() const;
  void clear();

protected:
  // introduced virtual methods:
  virtual int commonMargin(QCP::MarginSide side) const;

  // non-virtual methods:
  void addChild(QCP::MarginSide side, QCPLayoutElement *element);
  void removeChild(QCP::MarginSide side, QCPLayoutElement *element);
};


class QCPLayoutElement : public QCPLayerable
{
%TypeHeaderCode
#include <qcustomplot.h>
%End

%ConvertToSubClassCode
  QCPLayoutElement* element = qobject_cast<QCPLayoutElement*>(sipCpp);
  sipType = 0;
  if (element) {
    if (qobject_cast<QCPAxisRect*>(element) != 0)
      sipType = sipType_QCPAxisRect;
    else if (qobject_cast<QCPColorScale*>(element) != 0)
      sipType = sipType_QCPColorScale;
    else if (qobject_cast<QCPLegend*>(element) != 0)
      sipType = sipType_QCPLegend;
    else if (qobject_cast<QCPTextElement*>(element) != 0)
      sipType = sipType_QCPTextElement;
  }
%End

public:
  enum UpdatePhase { upPreparation ///< Phase used for any type of preparation that needs to be done before margin calculation and layout
                     ,upMargins    ///< Phase in which the margins are calculated and set
                     ,upLayout     ///< Final phase in which the layout system places the rects of the elements
                   };
  
  enum SizeConstraintRect { scrInnerRect ///< Minimum/Maximum size constraints apply to inner rect
                            , scrOuterRect ///< Minimum/Maximum size constraints apply to outer rect, thus include layout element margins
                          };

  explicit QCPLayoutElement(QCustomPlot *parentPlot /TransferThis/ = 0);
  virtual ~QCPLayoutElement();
  
  // getters:
  QCPLayout *layout() const;
  QRect rect() const;
  QRect outerRect() const;
  QMargins margins() const;
  QMargins minimumMargins() const;
  QCP::MarginSides autoMargins() const;
  QSize minimumSize() const;
  QSize maximumSize() const;
  SizeConstraintRect sizeConstraintRect() const;
  QCPMarginGroup *marginGroup(QCP::MarginSide side) const;
  QHash<QCP::MarginSide, QCPMarginGroup*> marginGroups() const;
  
  // setters:
  void setOuterRect(const QRect &rect);
  void setMargins(const QMargins &margins);
  void setMinimumMargins(const QMargins &margins);
  void setAutoMargins(QCP::MarginSides sides);
  void setMinimumSize(const QSize &size);
  void setMinimumSize(int width, int height);
  void setMaximumSize(const QSize &size);
  void setMaximumSize(int width, int height);
  void setSizeConstraintRect(SizeConstraintRect constraintRect);
  void setMarginGroup(QCP::MarginSides sides, QCPMarginGroup *group);
  
  // introduced virtual methods:
  virtual void update(UpdatePhase phase);
  virtual QSize minimumOuterSizeHint() const;
  virtual QSize maximumOuterSizeHint() const;
  virtual QList<QCPLayoutElement*> elements(bool recursive) const;
  
  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;

protected:
  // introduced virtual methods:
  virtual int calculateAutoMargin(QCP::MarginSide side);
  virtual void layoutChanged();

  // reimplemented virtual methods:
  virtual void applyDefaultAntialiasingHint(QCPPainter *painter) const;
  virtual void draw(QCPPainter *painter);
  virtual void parentPlotInitialized(QCustomPlot *parentPlot);
};


class QCPLayout : public QCPLayoutElement
{
%TypeHeaderCode
#include <qcustomplot.h>
%End

public:
  explicit QCPLayout();
  
  // reimplemented virtual methods:
  virtual void update(UpdatePhase phase);
  virtual QList<QCPLayoutElement*> elements(bool recursive) const;
  
  // introduced virtual methods:
  virtual int elementCount() const = 0;
  virtual QCPLayoutElement* elementAt(int index) const = 0;
  virtual QCPLayoutElement* takeAt(int index) = 0;
  virtual bool take(QCPLayoutElement *element) = 0;
  virtual void simplify();
  
  // non-virtual methods:
  bool removeAt(int index);
  bool remove(QCPLayoutElement *element);
  void clear();

protected:
  // introduced virtual methods:
  virtual void updateLayout();

  // non-virtual methods:
  void sizeConstraintsChanged() const;
  void adoptElement(QCPLayoutElement *el);
  void releaseElement(QCPLayoutElement *el);
  QVector<int> getSectionSizes(QVector<int> maxSizes, QVector<int> minSizes, QVector<double> stretchFactors, int totalSize) const;
  static QSize getFinalMinimumOuterSize(const QCPLayoutElement *el);
  static QSize getFinalMaximumOuterSize(const QCPLayoutElement *el);
};


class QCPLayoutGrid : public QCPLayout
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
 
public:
  enum FillOrder { foRowsFirst    ///< Rows are filled first, and a new element is wrapped to the next column if the row count would exceed \ref setWrap.
                  ,foColumnsFirst ///< Columns are filled first, and a new element is wrapped to the next row if the column count would exceed \ref setWrap.
                };
  
  explicit QCPLayoutGrid();
  virtual ~QCPLayoutGrid();
  
  // getters:
  int rowCount() const;
  int columnCount() const;
  QList<double> columnStretchFactors() const;
  QList<double> rowStretchFactors() const;
  int columnSpacing() const;
  int rowSpacing() const;
  int wrap() const;
  FillOrder fillOrder() const;
  
  // setters:
  void setColumnStretchFactor(int column, double factor);
  void setColumnStretchFactors(const QList<double> &factors);
  void setRowStretchFactor(int row, double factor);
  void setRowStretchFactors(const QList<double> &factors);
  void setColumnSpacing(int pixels);
  void setRowSpacing(int pixels);
  void setWrap(int count);
  void setFillOrder(FillOrder order, bool rearrange=true);
  
  // reimplemented virtual methods:
  virtual void updateLayout() ;
  virtual int elementCount() const;
  virtual QCPLayoutElement* elementAt(int index) const;
  virtual QCPLayoutElement* takeAt(int index);
  virtual bool take(QCPLayoutElement *element);
  virtual QList<QCPLayoutElement*> elements(bool recursive) const;
  virtual void simplify();
  virtual QSize minimumOuterSizeHint() const;
  virtual QSize maximumOuterSizeHint() const;
  
  // non-virtual methods:
  QCPLayoutElement *element(int row, int column) const;
  bool addElement(int row, int column, QCPLayoutElement *element);
  bool addElement(QCPLayoutElement *element);
  bool hasElement(int row, int column);
  void expandTo(int newRowCount, int newColumnCount);
  void insertRow(int newIndex);
  void insertColumn(int newIndex);
  int rowColToIndex(int row, int column) const;
  void indexToRowCol(int index, int &row, int &column) const;

protected:
  // non-virtual methods:
  void getMinimumRowColSizes(QVector<int> *minColWidths, QVector<int> *minRowHeights) const;
  void getMaximumRowColSizes(QVector<int> *maxColWidths, QVector<int> *maxRowHeights) const;
};


class QCPLayoutInset : public QCPLayout
{
%TypeHeaderCode
#include <qcustomplot.h>
%End

public:
  enum InsetPlacement { ipFree            ///< The element may be positioned/sized arbitrarily, see \ref setInsetRect
                        ,ipBorderAligned  ///< The element is aligned to one of the layout sides, see \ref setInsetAlignment
                      };
  
  explicit QCPLayoutInset();
  virtual ~QCPLayoutInset();
  
  // getters:
  InsetPlacement insetPlacement(int index) const;
  Qt::Alignment insetAlignment(int index) const;
  QRectF insetRect(int index) const;
  
  // setters:
  void setInsetPlacement(int index, InsetPlacement placement);
  void setInsetAlignment(int index, Qt::Alignment alignment);
  void setInsetRect(int index, const QRectF &rect);
  
  // reimplemented virtual methods:
  virtual void updateLayout();
  virtual int elementCount() const;
  virtual QCPLayoutElement* elementAt(int index) const;
  virtual QCPLayoutElement* takeAt(int index);
  virtual bool take(QCPLayoutElement *element);
  virtual void simplify();
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  
  // non-virtual methods:
  void addElement(QCPLayoutElement *element, Qt::Alignment alignment);
  void addElement(QCPLayoutElement *element, const QRectF &rect);
};
